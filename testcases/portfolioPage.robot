
*** Settings ***
Documentation     A test suite with a single test for checking  Portfolio page
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
${BALANCE}
*** Keywords ***

Verify the page is loaded successfuly

    sleep  5
    page should contain                     Portfolio
    wait until element is visible           xpath=//*[@id="portfolio-content"]/div[1]
    ${BALANCE_PORTFOLIO}    get text        xpath=//*[@id="portfolio-balance"]
    should be equal     ${BALANCE}       ${BALANCE_PORTFOLIO}
    ${NO_CONTRACT}  run keyword and return status   element should be visible      xpath=//*[@id="portfolio-no-contract"]
    run keyword if      ${NO_CONTRACT}      Verify no open positions


Verify no open positions

    element text should be    xpath=//*[@id="portfolio-no-contract"]/p        No open positions.
    element should not be visible   xpath=//*[@id="portfolio-table"]


Verify recent bought contract added in portfolio page

    page should contain         ${CONTRACT_REF_ID}
    element should be visible   xpath=//*[@id="portfolio-table"]
    element should be visible   xpath=//*[@id="portfolio-body"]/tr[contains(.,"${CONTRACT_REF_ID}")]/td[6]/button
    ${PURCHASE_PRICE_PORTFOLIO}     get text       xpath=//*[@id="portfolio-body"]/tr[contains(.,"${CONTRACT_REF_ID}")]/td[4]
    should be equal     ${PURCHASE_PRICE}       ${PURCHASE_PRICE_PORTFOLIO}
    click button                xpath=//*[@id="portfolio-body"]/tr[contains(.,"${CONTRACT_REF_ID}")]/td[6]/button
    Wait Until Page Contains	Contract Information	5
    page should contain      Volatility 10 Index
    element should be visible  xpath=//*[@id="trade_details_ref_id"]
    ${LATEST_REFERENCE_ID}      get text  xpath=//*[@id="trade_details_ref_id"]
    should be equal         ${LATEST_REFERENCE_ID}              ${CONTRACT_REF_ID}
    element should be enabled  xpath=//*[@id="sell_at_market"]
    Wait Until Page Contains Element  id=sell_at_market
    wait until element is enabled   sell_at_market
    Click button  xpath=//*[@id="sell_at_market"]
    Wait Until Page Contains  You have sold this contract   5
    click element  xpath=//*[@id="sell_popup_container"]/a
    sleep  3

Verify recent sold removed from portfolio page


    ${BALANCE_AFTERSOLD}      get text  xpath=//*[@id="main-account"]/li/a/div[1]/div[3]
    ${BALANCE_AFTERSOLDPORTFOLIO}    get text        xpath=//*[@id="portfolio-balance"]
    should be equal     ${BALANCE_AFTERSOLD}       ${BALANCE_AFTERSOLDPORTFOLIO}
    wait until element is not visible       xpath=//*[@id="portfolio-body"]/tr[contains(.,"${CONTRACT_REF_ID}")]/td[6]/button      10
    page should not contain                 ${CONTRACT_REF_ID}
    element should not be visible           xpath=//*[@id="portfolio-body"]/tr[contains(.,"${CONTRACT_REF_ID}")]/td[6]/button
    ${NO_CONTRACT}  run keyword and return status   element should be visible      xpath=//*[@id="portfolio-no-contract"]
    run keyword if      ${NO_CONTRACT}      Verify no open positions


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
    ${BALANCE}      get text  xpath=//*[@id="main-account"]/li/a/div[1]/div[3]
    set global variable  ${BALANCE}
    click element  xpath=//*[@id="sell_popup_container"]/a


*** Test Cases ***
Check Portfolio Page
    valid login
    switch virtual account
    sleep  5
    buy a contract
    Navigate to Portfolio Page
    verify the page is loaded successfuly
    verify recent bought contract added in portfolio page
    verify recent sold removed from portfolio page
    capture page screenshot         screenshots/PortfolioPage.png
    [Teardown]    Close Browser
