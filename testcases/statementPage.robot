
*** Settings ***
Documentation     A test suite with a single test for checking  Statement page
...
...               This test has a workflow that is created using keywords in
...               the imported resource file.
Resource          ../common/resource.robot
Resource          ../common/navigation.robot
Library            String
Library            Collections


*** Variables ***
${CONTRACT_REF_ID}
${CONTRACT_SOLD_REF_ID}
${PURCHASE_PRICE}
${SELL_PRICE}
*** Keywords ***

Navigate to personal details page
    sleep  3
    Navigate to profile
    wait until element is visible   xpath=//*[@id="settings_container"]/div/div[2]/div[1]/a
    click element                   xpath=//*[@id="settings_container"]/div/div[2]/div[1]/a


Verify the page is loaded successfuly

    sleep  10
    page should contain                     Statement
    wait until element is visible           xpath=//*[@id="statement-table"]
    wait until element is visible           xpath=//*[@id="statement-table"]/tbody/tr[1]
    wait until element is visible           //*[@id="statement-table"]/tbody/tr[1]/td[5]/button

Verify recent bought contract added in statement page
    element text should be      xpath=//*[@id="statement-table"]/tbody/tr[contains(.,"${CONTRACT_REF_ID}")]/td[4]      Buy
    ${DEBIT}       get text    xpath=//*[@id="statement-table"]/tbody/tr[contains(.,"${CONTRACT_REF_ID}")]/td[6]
    ${DEBIT_AMOUNT}    fetch from right    ${DEBIT}     -
    should be equal      ${DEBIT_AMOUNT}      ${PURCHASE_PRICE}
    ${REFERENCE_ID}  GET TEXT  xpath=//*[@id="statement-table"]/tbody/tr[contains(.,"${CONTRACT_REF_ID}")]/td[2]/span
    click element        xpath=//*[@id="statement-table"]/tbody/tr[1]/td[5]/button
    Wait Until Page Contains	Contract Information	10
    page should contain      Volatility 10 Index
    element should be visible  xpath=//*[@id="trade_details_ref_id"]
    ${LATEST_REFERENCE_ID}      get text  xpath=//*[@id="trade_details_ref_id"]
    should be equal         ${LATEST_REFERENCE_ID}              ${REFERENCE_ID}             ${CONTRACT_REF_ID}
    element should be enabled  xpath=//*[@id="sell_at_market"]
    Wait Until Page Contains Element  id=sell_at_market
    wait until element is enabled   sell_at_market
    Click button  xpath=//*[@id="sell_at_market"]
    Wait Until Page Contains  You have sold this contract   10
    ${REFF_ID_AFTER_SOLD}      get text  xpath=//*[@id="trade_details_ref_id"]
    ${CONTRACT_SOLD_REF_ID}       fetch from right    ${REFF_ID_AFTER_SOLD}  -${space}
    strip string  ${CONTRACT_SOLD_REF_ID}
    set global variable   ${CONTRACT_SOLD_REF_ID}
    ${SELL_PRICE}   get text    xpath=//*[@id="trade_details_indicative_price"]
    set global variable     ${SELL_PRICE}
    click element  xpath=//*[@id="sell_popup_container"]/a

Verify recent sold contract added in statement page

    reload page
    wait until page contains        Potential Payout         10
    element text should be          xpath=//*[@id="statement-table"]/tbody/tr[1]/td[4]      Sell
    ${BUY_REF_ID}        GET TEXT   xpath=//*[@id="statement-table"]/tbody/tr[contains(.,"${CONTRACT_REF_ID}")]/td[2]/span
    ${SELL_REF_ID}       GET TEXT   xpath=//*[@id="statement-table"]/tbody/tr[contains(.,"${CONTRACT_SOLD_REF_ID}")]/td[2]/span
    should not be equal     ${BUY_REF_ID}       ${SELL_REF_ID}
    ${CREDIT_AMOUNT}       get text    xpath=//*[@id="statement-table"]/tbody/tr[contains(.,"${CONTRACT_SOLD_REF_ID}")]/td[6]
    should be equal      ${SELL_PRICE}          ${CREDIT_AMOUNT}

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
    Click Element  id=contract_purchase_button
    wait until element is visible       xpath=//*[@id="sell_bet_desc"]
    ${CONTRACT_REF_ID}      get text    xpath=//*[@id="trade_details_ref_id"]
    set global variable        ${CONTRACT_REF_ID}
    ${PURCHASE_PRICE}       get text  xpath=//*[@id="trade_details_purchase_price"]
    set global variable      ${PURCHASE_PRICE}
    click element  xpath=//*[@id="sell_popup_container"]/a




*** Test Cases ***
Check Statement Page
    open xvfb browser then login
    switch virtual account
    buy a contract
    Navigate to Statement Page
    verify the page is loaded successfuly
    verify recent bought contract added in statement page
    verify recent sold contract added in statement page
    capture page screenshot         screenshots/statementPage.png
    [Teardown]    Close Browser
