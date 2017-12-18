*** Settings ***
Documentation     A test suite with test for digit contract
...
...               This test has a workflow that is created using keywords in
...               the imported resource file.
Resource          ../common/resource.robot
Resource          ../common/contract_resource.robot
Resource          ../common/navigation.robot
Library           String
Library           Collections
Library           DateTime

*** Variables ***
${exit_spot_element}    xpath=//*[@id="trade_details_spot_label"]//parent::tr[@class="invisible"]
${zero_remaining_time}  xpath=//td[contains(@id, 'trade_details_live_remaining') and text()='-']


*** Keywords ***
View contract on trading page
    Wait until element is visible       contract_purchase_spots
    Wait Until Page Contains            Tick ${duration_value}


Check contract end

    ${RESULT}  run keyword and return status   page should contain        xpath=//*[@id="contract_purchase_profit"]     Lost
    run keyword if      ${RESULT}       contract lost
    ...  ELSE
    ...  run keyword     Contract Won


Contract Won
    Log to console  This should be won  # Logging this so easier to debug if test case fail
    Verify Digit contract purchase
    Should Be True	${profit_lost_evaluate} > 0

Contract Lost
    Log to console  This should be lost     # Logging this so easier to debug if test case fail
    Verify Profit Lost Amount
    Should Be True	${profit_lost_evaluate} < 0



*** Test Cases ***
Check Match/Differ Contract
    Open xvfb browser then login
    Switch Virtual Account
    Choose Underlying    volidx  R_10
    buy a digit contract    5   ticks     1
    Verify Tick Contract Result
    capture page screenshot
    [Teardown]    Close Browser
