
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
${INV_CHAR_ADRRESS_MSG}               Only letters, numbers, space, and these special characters are allowed: - . ' # ; : ( ) , @ /
${INV_CHAR_TAX_ZIP_NO_MSG}            Only letters, numbers, space, and hyphen are allowed.
${INV_CHAR_CITY_MSG}                  Only letters, space, hyphen, period, and apostrophe are allowed.
${INV_CHAR_PHONE_MSG}                 Only numbers and spaces are allowed.
${MIN_INPUT_NO}                       1234
${MIN_PHONE_NO_MSG}                   You should enter 6-35 characters.

*** Keywords ***

Navigate to personal details page
    sleep  3
    Navigate to profile
    wait until element is visible   xpath=//*[@id="settings_container"]/div/div[2]/div[1]/a
    click element                   xpath=//*[@id="settings_container"]/div/div[2]/div[1]/a


Verify the page is loaded successfuly

    sleep  5
    page should contain                     Statement
    wait until element is visible           xpath=//*[@id="statement-table"]
    wait until element is visible           xpath=//*[@id="statement-table"]/tbody/tr[1]
    wait until element is visible           //*[@id="statement-table"]/tbody/tr[1]/td[5]/button

Verify recent bought contract added in statement page
    element text should be      xpath=//*[@id="statement-table"]/tbody/tr[1]/td[4]      Buy
    ${REFERENCE_ID}  GET TEXT  xpath=//*[@id="statement-table"]/tbody/tr[1]/td[2]/span
    click element        xpath=//*[@id="statement-table"]/tbody/tr[1]/td[5]/button
    Wait Until Page Contains	Contract Information	10
    page should contain      Volatility 10 Index
    element should be visible  xpath=//*[@id="trade_details_ref_id"]
    ${LATEST_REFERENCE_ID}      get text  xpath=//*[@id="trade_details_ref_id"]
    should be equal         ${LATEST_REFERENCE_ID}              ${REFERENCE_ID}
    element should be enabled  xpath=//*[@id="sell_at_market"]
    Wait Until Page Contains Element  id=sell_at_market
    wait until element is enabled   sell_at_market
    Click button  xpath=//*[@id="sell_at_market"]
    Wait Until Page Contains  You have sold this contract   10
    click element  xpath=//*[@id="sell_popup_container"]/a

Verify recent sold contract added in statement page

    reload page
    wait until page contains        Potential Payout         10
    element text should be          xpath=//*[@id="statement-table"]/tbody/tr[1]/td[4]      Sell
    ${BUY_REF_ID}        GET TEXT   xpath=//*[@id="statement-table"]/tbody/tr[2]/td[2]/span
    ${SELL_REF_ID}       GET TEXT   xpath=//*[@id="statement-table"]/tbody/tr[1]/td[2]/span
    should not be equal     ${BUY_REF_ID}       ${SELL_REF_ID}

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
    Wait Until Page Contains	Contract Confirmation	60
    Click Element  id=contract_purchase_button
    wait until element is visible       xpath=//*[@id="sell_bet_desc"]
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
    capture page screenshot         screenshots/changepassword.png
    [Teardown]    Close Browser
