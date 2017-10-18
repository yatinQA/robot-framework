*** Settings ***
Documentation     A test suite with a single test for checking  Profit Table page
...
...               This test has a workflow that is created using keywords in
...               the imported resource file.
Resource          ../common/resource.robot
Resource          ../common/navigation.robot
Library            String
Library            Collections


*** Variables ***
${CONTRACT_REF_ID}
${PURCHASE_PRICE}
${LOST_AMOUNT_NO}
${SALE_PRICE}
*** Keywords ***

Verify the page is loaded successfuly

    sleep  5
    page should contain                     Profit Table
    wait until element is visible           xpath=//*[@id="profit-table"]
    wait until element is visible           xpath=//*[@id="profit-table"]/tbody/tr[1]



Verify recent bought contract added in profit table page

    page should contain         ${CONTRACT_REF_ID}
    element should be visible   xpath=//*[@id="profit-table"]/tbody/tr[1]/td[4]/button
    element should be visible   xpath=//*[@id="profit-table"]/tbody/tr[contains(.,"${CONTRACT_REF_ID}")]/td[4]/button
    ${PURCHASE_PRICE_PROFIT}     get text       xpath=//*[@id="profit-table"]/tbody/tr[contains(.,"${CONTRACT_REF_ID}")]/td[5]
    should be equal     ${PURCHASE_PRICE}       ${PURCHASE_PRICE_PROFIT}
    ${SALE_PRICE_PROFIT}        get text    xpath=//*[@id="profit-table"]/tbody/tr[contains(.,"${CONTRACT_REF_ID}")]/td[7]
    should be equal     ${SALE_PRICE_PROFIT}    ${SALE_PRICE}
    click button                xpath=//*[@id="profit-table"]/tbody/tr[contains(.,"${CONTRACT_REF_ID}")]/td[4]/button
    Wait Until Page Contains	Contract Information	5
    page should contain      Volatility 10 Index
    element should be visible  xpath=//*[@id="trade_details_ref_id"]
    element should be visible  xpath=//*[@id="trade_details_current_title"]
    element text should be  xpath=//*[@id="trade_details_indicative_price"]        ${SALE_PRICE_PROFIT}
    click element  xpath=//*[@id="sell_popup_container"]/a
    ${LOST_AMOUNT_PROFIT}         get text  xpath=//*[@id="profit-table"]/tbody/tr[contains(.,"${CONTRACT_REF_ID}")]/td[8]
    should be equal             ${LOST_AMOUNT_NO}            ${LOST_AMOUNT_PROFIT}



Buy a contract
    Click Element	id=contract_markets
    Wait Until Element Is Visible	contract_markets   10
    Select From List By Label	id=contract_markets	Volatility Indices
    click element  css=option[value="volidx"]
    Sleep   3
    Input Text  duration_amount  1
    Sleep   3
    Select From List	id=duration_units	days
    Wait Until Element Is Visible	purchase_button_bottom	10
    Sleep   5
    Click Element	purchase_button_top
    Wait Until Page Contains	Contract Confirmation	10
    sleep  5
    Click Element  id=contract_purchase_button
    Wait Until Page Contains	Contract Information	60
    element should be enabled  xpath=//*[@id="sell_at_market"]
    Wait Until Page Contains Element  id=sell_at_market
    wait until element is enabled   sell_at_market
    Click button  xpath=//*[@id="sell_at_market"]
    Wait Until Page Contains  You have sold this contract   10
    ${CONTRACT_BUY_REF_ID}      get text    xpath=//*[@id="trade_details_ref_id"]
    ${CONTRACT_REF_ID}       fetch from left   ${CONTRACT_BUY_REF_ID}  ${space}-${space}
    set global variable        ${CONTRACT_REF_ID}
    ${PURCHASE_PRICE}       get text  xpath=//*[@id="trade_details_purchase_price"]
    set global variable      ${PURCHASE_PRICE}
    ${LOST_AMOUNT}	            Get Text	        id=trade_details_profit_loss
    ${percent}	                Get Text	        xpath=//td[@id='trade_details_profit_loss']//span[@class='percent']
    ${LOST_AMOUNT_NO}	        Remove String	    ${LOST_AMOUNT}  ${percent}
    set global variable  ${LOST_AMOUNT_NO}
    ${SALE_PRICE}   get text  xpath=//*[@id="trade_details_indicative_price"]
    set global variable    ${SALE_PRICE}
    click element  xpath=//*[@id="sell_popup_container"]/a


*** Test Cases ***
Check Profit Table Page
    open xvfb browser then login
    switch virtual account
    sleep  5
    buy a contract
    Navigate to Profit Table Page
    verify the page is loaded successfuly
    verify recent bought contract added in profit table page
    capture page screenshot         screenshots/ProfitTabelPage.png
    [Teardown]    Close Browser
