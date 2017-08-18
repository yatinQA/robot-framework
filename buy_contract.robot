*** Settings ***
Documentation     A test suite with a single test for buying Up/Down Rise/Fall contract.
...
...               This test has a workflow that is created using keywords in
...               the imported resource file.
Resource          resource.robot

*** Variables ***
${profit_lost_evaluate}		0

*** Keywords ***
Contract Won
    Page Should Contain	This contract won
    ${profit_lost}=	Get Text	id=contract_purchase_profit
    ${profit_lost}=	Get Line	${profit_lost}	1
    ${profit_lost}=	Get Substring	${profit_lost}	0
    Should Be True	'${profit_lost}' == '${profit_lost_evaluate}'	    

Contract Lost
    Page Should Contain	This contract lost
    ${profit_lost}=	Get Text	id=contract_purchase_profit
    ${profit_lost}=	Get Line	${profit_lost}	1
    ${profit_lost_evaluate}=	Convert To String	${profit_lost_evaluate}
    ${profit_lost_evaluate}=	Get Substring	${profit_lost_evaluate}   1
    ${profit_lost_evaluate}=	Catenate	-${profit_lost_evaluate}
    Should Be True	'${profit_lost}' == '${profit_lost_evaluate}'	

Verify Contract Result
    ${buy_price}=	Get Text	id=contract_purchase_payout
    ${buy_price}=	Get Line	${buy_price}	1
    ${buy_price}=	Get Substring	${buy_price}	0

    ${final_price}=	Get Text	id=contract_purchase_cost
    ${final_price}=	Get Line	${final_price}	1
    ${final_price}=	Get Substring	${final_price}	0

    ${profit_lost_evaluate}=	Evaluate	${final_price} - ${buy_price}
    Set Global Variable		${profit_lost_evaluate}
    ${status}=	Evaluate	${final_price} > ${buy_price}

    Run Keyword If	${status} == 1	Contract Won 
    Run Keyword If	${status} == 0	Contract Lost 	    

*** Test Cases ***
Trade Up Down
    Valid Login
    Switch Virtual Account
    Click Element	id=contract_markets
    Wait Until Element Is Visible	contract_markets   10
    Select From List By Label	id=contract_markets	Volatility Indices
    Click Element	css=option[value="volidx"]
    #Click Element 	xpath=//*[@id="contract_form_name_nav"]/li[5]
    #Click Element	id=matchdiff
    #Click Element	xpath=id('contract_form_name_nav')/x:li[5]/x:a
    #Click Link	duration_amount
    #Click Element	css=input[type="submit"]
    Sleep   3
    Input Text  duration_amount  5
    Sleep   3
    Select From List	id=duration_units	ticks
    Wait Until Element Is Visible	purchase_button_bottom	10	
    Click Element	purchase_button_bottom	
    Wait Until Page Contains	This contract	60
    Capture Page Screenshot
    Verify Contract Result
    [Teardown]    Close Browser
