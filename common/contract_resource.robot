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
${profit_lost_evaluate}

*** Keywords ***
Count contract waiting time
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
    [Arguments]     ${market}   ${underlying}
    Click element	id=contract_markets
    Wait until element is visible	contract_markets   10
    Click element	xpath = //*[@id="contract_markets"]/option[@value='${market}']
    Click element	xpath = //*[@id="underlying"]/option[@value="${underlying}"]
    Sleep   3


Buy Touch No Touch Contract
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
    Sleep   2
    Wait Until Page Contains Element    xpath=//*[@class="contract_purchase button"]         5
    Wait Until Page Contains Element    id = spot
    Click element   id = purchase_button_top
    Wait Until Page Contains	Contract Confirmation	10
    Count contract waiting time
    [Return]    ${duration_value}   ${duration_unit}    ${barrier_value}


Verify Profit Lost Amount
    ${buy_price}=	            Get Text	id=trade_details_purchase_price
    ${final_price}=	            Get Text	id=trade_details_indicative_price

    ${profit_lost_evaluate}=	Evaluate	${final_price} - ${buy_price}
    ${profit_lost_evaluate}=    Evaluate    "%.2f" % ${profit_lost_evaluate}
    Set global variable         ${profit_lost_evaluate}

    ${profit_lost}=	            Get Text	        id=trade_details_profit_loss
    ${percent}=	                Get Text	        xpath=//td[@id='trade_details_profit_loss']//span[@class='percent']
    ${profit_lost}=	            Remove String	    ${profit_lost}  ${percent}

    Should Be True	    '${profit_lost}' == '${profit_lost_evaluate}'
