*** Settings ***
Documentation     A resource file with reusable keywords and variables for contract.
...
...               The system specific keywords created here form our own
...               domain specific language. They utilize keywords provided
...               by the imported Selenium2Library.
Library		      String
Library           Selenium2Library

*** Variables ***
${duration_value}
${duration_unit}
${barrier_value}
${higher_barrier_offset}
${lower_barrier_offset}
${profit_lost_evaluate}
${tick_value}
${status}
${Digit_type}
${MatchDiffer_digit_type}      Matches/Differs
${overunder_digit_type}         Over/Under
${evenodd_digit_type}          Even/Odd
${digit_market_type}
${Amount}

*** Keywords ***
Count contract waiting time
# To calculate the waiting time based on contract duration and duration unit
    ${unit}=    Run keyword if  "${duration_unit}"=="minutes"
    ...     Set variable    60
    ...     ELSE
    ...     Run keyword if  "${duration_unit}"=="hours"
    ...     Set variable    3600
    ...     ELSE
    ...     Run keyword if  "${duration_unit}"=="days"
    ...     Set variable    216000
    ${contract_duration} =  Evaluate    ${duration_value} * ${unit}
    Set global variable         ${contract_duration}

Choose Underlying
# To choose market and underlying
    [Arguments]     ${market}   ${underlying}
    Wait until page contains element    id = contract_markets_container
    Click element	id=contract_markets
    Wait until element is visible	contract_markets   10
    Click element	xpath = //*[@id="contract_markets"]/option[@value='${market}']
    Click element	xpath = //*[@id="underlying"]/option[@value="${underlying}"]
    Sleep   3

Buy Touch No Touch Contract
# To purchase Touches contract
    [Arguments]     ${duration_value}   ${duration_unit}    ${barrier_value}
    Set global variable     ${duration_value}
    Set global variable     ${duration_unit}
    Set global variable     ${barrier_value}
    Click element   id = touchnotouch
    Wait Until Page Contains    Barrier offset
    # set duration
    Select From List	id=duration_units	${duration_unit}
    Wait Until Page Contains Element    id = spot
    Input Text  id = duration_amount  ${duration_value}
    Wait Until Page Contains Element    id = spot
    # set barrier
    Input Text  id = barrier  ${barrier_value}
    Sleep   5
    Wait Until Page Contains Element    xpath=//*[@class="contract_purchase button"]         10
    Wait Until Page Contains Element    id = spot
    Click element   id = purchase_button_top
    Wait Until Page Contains	Contract Confirmation	10
    Count contract waiting time
    [Return]    ${duration_value}   ${duration_unit}    ${barrier_value}

Buy Asians Contract
# To purchase Asian Up contract
    [Arguments]     ${tick_value}
    Set global variable     ${tick_value}
    Click element   id = asian
    Wait Until Page Contains    asian up
    # set duration
    Input Text  id = duration_amount   ${tick_value}
    Sleep   5
    # purchase Asian Up
    #Wait Until Page Contains Element    xpath=//*[@class="contract_purchase button"]         10
    Wait Until Page Contains Element    id = spot
    Click element   id = purchase_button_top
    Wait Until Page Contains	Contract Confirmation	10
    Wait Until Page Contains	This contract	60
    [Return]    ${tick_value}

Buy a Digit Contract

    # To purchase Touches contract
    [Arguments]     ${duration_value}   ${duration_unit}    ${barrier_value}     ${digit_market_type}
    Set global variable     ${duration_value}
    Set global variable     ${duration_unit}
    Set global variable     ${barrier_value}
    set global variable     ${digit_market_type}
    Click element   xpath=//*[@id="contract_form_name_nav"]/li[5]/a
    click element   ${digit_market_type}
    Wait Until Page Contains   Last Digit Prediction
    ${Digit type}   get text    ${digit_market_type}
    set global variable    ${Digit_type}
    # set duration
    Select From List	id=duration_units	${duration_unit}
    Wait Until Page Contains Element    id = spot
    Input Text  id = duration_amount  ${duration_value}
    Wait Until Page Contains Element    id = spot
    # set barrier
    Sleep   5
    select from list  id = prediction  ${barrier_value}
    Wait Until Page Contains Element    xpath=//*[@class="contract_purchase button"]         10
    Wait Until Page Contains Element    id = spot
    Click element   id = purchase_button_top
    Wait Until Page Contains	This contract	60
    [Return]    ${duration_value}   ${duration_unit}    ${barrier_value}     ${digit_market_type}

Buy a Digit-Even/Odd Contract

    # To purchase Touches contract
    [Arguments]     ${duration_value}   ${duration_unit}       ${digit_market_type}     ${Amount}
    Set global variable     ${duration_value}
    Set global variable     ${duration_unit}
    set global variable     ${digit_market_type}
    set global variable     ${Amount}
    Click element   xpath=//*[@id="contract_form_name_nav"]/li[5]/a
    click element   ${digit_market_type}
    Wait Until Page Contains   The minimum duration is 5 ticks
    ${Digit type}   get text    ${digit_market_type}
    set global variable    ${Digit_type}
    # set duration
    Select From List	id=duration_units	${duration_unit}
    Wait Until Page Contains Element    id = spot
    Input Text  id = duration_amount  ${duration_value}
    clear element text   id = duration_amount
    sleep  5
    Input Text  id = duration_amount  ${duration_value}
    #clear element text    id = amount
    #sleep  1
    # input text  id = amount        ${Amount} + 1
    Wait Until Page Contains Element    id = spot
    # set barrier
    Sleep   2
    Wait Until Page Contains Element    xpath=//*[@class="contract_purchase button"]         10
    Wait Until Page Contains Element    id = spot
    Click element   id = purchase_button_top
    Wait Until Page Contains	This contract	60
    [Return]    ${duration_value}   ${duration_unit}    ${barrier_value}     ${digit_market_type}    ${Amount}

Verify Profit Lost Amount
# This is to verify the Profit/Loss amount in Contract information page
    ${buy_price}=	            Get Text	id=trade_details_purchase_price
    ${final_price}=	            Get Text	id=trade_details_indicative_price

    ${profit_lost_evaluate}=	Evaluate	${final_price} - ${buy_price}
    ${profit_lost_evaluate}=    Evaluate    "%.2f" % ${profit_lost_evaluate}
    Set global variable         ${profit_lost_evaluate}

    ${profit_lost}=	            Get Text	        id=trade_details_profit_loss
    ${percent}=	                Get Text	        xpath=//td[@id='trade_details_profit_loss']//span[@class='percent']
    ${profit_lost}=	            Remove String	    ${profit_lost}  ${percent}

    Should Be True	    '${profit_lost}' == '${profit_lost_evaluate}'


Verify Tick Contract Result
# This is used for Tick contract - verifying result on trading page
    ${buy_price}=	Get Text	id=contract_purchase_payout
    ${buy_price}=	Get Line	${buy_price}	1
    ${buy_price}=	Get Substring	${buy_price}	0

    ${final_price}=	Get Text	id=contract_purchase_cost
    ${final_price}=	Get Line	${final_price}	1
    ${final_price}=	Get Substring	${final_price}	0

    ${profit_lost_evaluate}=	Evaluate	${final_price} - ${buy_price}
    ${profit_lost_evaluate}=	Evaluate      "%.2f" % ${profit_lost_evaluate}
    Set Global Variable		${profit_lost_evaluate}
    ${status}=	Evaluate	${final_price} > ${buy_price}
    set global variable    ${status}

    Run Keyword If	${status} == 1	Tick Contract Won
    Run Keyword If	${status} == 0	Tick Contract Lost


Tick Contract Won
# This is used for Tick contract - verifying result on trading page
    Page Should Contain	This contract won
    ${profit_lost}=	Get Text	id=contract_purchase_profit
    ${profit_lost}=	Get Line	${profit_lost}	1
    ${profit_lost}=	Get Substring	${profit_lost}	0
    Should Be True	'${profit_lost}' == '${profit_lost_evaluate}'


Tick Contract Lost
# This is used for Tick contract - verifying result on trading page
    Page Should Contain	This contract lost
    ${profit_lost}=	Get Text	id=contract_purchase_profit
    ${profit_lost}=	Get Line	${profit_lost}	1
    ${profit_lost_evaluate}=	Convert To String	${profit_lost_evaluate}
    ${profit_lost_evaluate}=	Get Substring	${profit_lost_evaluate}   1
    ${profit_lost_evaluate}=	Catenate	-${profit_lost_evaluate}
    Should Be True	'${profit_lost}' == '${profit_lost_evaluate}'


Check last digit

#This to check the last digit , should follow  contract defination
    Run Keyword If	${status} == 1 and '${Digit_type}' == '${MatchDiffer_digit_type}'         digit match verification
    Run Keyword If	${status} == 0 and '${Digit_type}' == '${MatchDiffer_digit_type}'         digit differ verification
    Run Keyword If	${status} == 1 and '${Digit_type}' == '${overunder_digit_type}'           digit over verification
    Run Keyword If	${status} == 0 and '${Digit_type}' == '${overunder_digit_type}'           digit lower verification
    Run Keyword If	${status} == 1 and '${Digit_type}' == '${evenodd_digit_type}'             digit even verification
    Run Keyword If	${status} == 0 and '${Digit_type}' == '${evenodd_digit_type}'             digit odd verification



Digit match verification

    log to console      This contract is won and last digit is match
    ${lastDigit}        get text    xpath=//*[@id="contract_purchase_spots"]/div[${duration_value}]/div[3]
    should end with    ${LastDigit}      ${barrier_value}

Digit differ verification
     log to console      This contract is loss and last digit is differ
    ${lastDigit}        get text    xpath=//*[@id="contract_purchase_spots"]/div[${duration_value}]/div[3]
    should not end with    ${LastDigit}      ${barrier_value}


Digit over verification
    log to console      This contract is won and last digit is higher
    ${lastDigit}        get text    xpath=//*[@id="contract_purchase_spots"]/div[${duration_value}]/div[3]
    ${lastDigit}        get substring  ${lastDigit}    -1
    ${last_digit_evaluate}      evaluate   ${lastDigit} >= ${barrier_value}
    should be true      ${last_digit_evaluate}

Digit lower verification

    log to console      This contract is loss and last digit is lower
    ${lastDigit}        get text    xpath=//*[@id="contract_purchase_spots"]/div[${duration_value}]/div[3]
    ${lastDigit}        get substring  ${lastDigit}    -1
    ${last_digit_evaluate}      evaluate   ${lastDigit} <= ${barrier_value}
    should be true      ${last_digit_evaluate}


Digit even verification

    log to console    This contract is won and last digit is even
    ${lastDigit}        get text    xpath=//*[@id="contract_purchase_spots"]/div[${duration_value}]/div[3]
    ${lastDigit}        get substring  ${lastDigit}    -1
    should contain any    ${lastDigit}  0  2   4  6  8

Digit odd verification

    log to console    This contract is loss and last digit is odd
    ${lastDigit}        get text    xpath=//*[@id="contract_purchase_spots"]/div[${duration_value}]/div[3]
    ${lastDigit}        get substring  ${lastDigit}    -1
    should contain any    ${lastDigit}  1  3   5  7  9

