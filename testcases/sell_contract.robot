*** Settings ***
Documentation     A test suite with a single test for buying then manual sell Up/Down Rise/Fall contract.
...
...               This test has a workflow that is created using keywords in
...               the imported resource file.
Resource          ../common/resource.robot

*** Variables ***
${profit_lost_evaluate}		0


*** Keywords ***
Verify Contract Result
    ${buy_price}=	            Get Text	id=trade_details_purchase_price
    ${final_price}=	            Get Text	id=trade_details_indicative_price

    ${profit_lost_evaluate}=	Evaluate	${final_price} - ${buy_price}
    ${profit_lost_evaluate}=    Evaluate    "%.2f" % ${profit_lost_evaluate}

    ${profit_lost}=	            Get Text	        id=trade_details_profit_loss
    ${percent}=	                Get Text	        xpath=//td[@id='trade_details_profit_loss']//span[@class='percent']
    ${profit_lost}=	            Remove String	    ${profit_lost}  ${percent}
    ${profit_lost_evaluate}=	Convert To String	${profit_lost_evaluate}
    Should Be True	'${profit_lost}' == '${profit_lost_evaluate}'


*** Test Cases ***
Buy and Sell Contract
    open xvfb browser then login
    Switch Virtual Account
    Click Element	id=contract_markets
    Wait Until Element Is Visible	contract_markets   10
    Select From List By Label	id=contract_markets	Volatility Indices
    Click Element	css=option[value="volidx"]
    Sleep   3
    Input Text  duration_amount  1
    Sleep   3
    Select From List	id=duration_units	days
    Wait Until Element Is Visible	purchase_button_bottom	10
    Sleep   5
    Click Element	purchase_button_top
    Wait Until Page Contains	Contract Confirmation	60
    Click Element  id=contract_purchase_button
    Wait Until Page Contains	Contract Information	60
    Wait Until Page Contains Element  id=sell_at_market
    wait until element is enabled   sell_at_market
    Click button  xpath=//*[@id="sell_at_market"]
    Wait Until Page Contains  You have sold this contract   10
    Capture Page Screenshot   screenshots/contractsell.png
    Verify Contract Result
    [Teardown]    Close Browser
