*** Settings ***
Documentation     A test suite with test for touch or no touch contract
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
    Click Element  id=contract_purchase_button
    Wait until element is visible       xpath=//*[@id="sell_bet_desc"]
    Wait until element is visible  xpath=//*[@id="trade_details_live_remaining"]
    ${end_time}      get text    xpath=//*[@id="trade_details_end_date"]
    Set global variable        ${end_time}
    Wait Until Page Contains Element     ${zero_remaining_time}       ${contract_duration}
    Sleep   2
    ${current_time}      get text    xpath=//*[@id="trade_details_live_date"]
    Set global variable        ${current_time}

Check touch or no touch
    ${current_time_format}=     Convert Date       ${current_time}         exclude_millis=True
    ${end_time_format}=     Convert Date       ${end_time}     exclude_millis=True
    ${time}=    Subtract Date From Date     ${end_time_format}     ${current_time_format}
    Run Keyword If	${time} > 0	Contract Won
    Run Keyword If	${time} < 0	Contract Lost

Contract Won
    Log to console  This should be won  # Logging this so easier to debug if test case fail
    Verify Profit Lost Amount
    Should Be True	${profit_lost_evaluate} > 0
    Page should contain element    ${exit_spot_element}

Contract Lost
    Log to console  This should be lost     # Logging this so easier to debug if test case fail
    Verify Profit Lost Amount
    Should Be True	${profit_lost_evaluate} < 0
    Page should not contain element    ${exit_spot_element}


*** Test Cases ***
Buy touch or no touch contract
    [Tags]  Long contract test
    Open xvfb browser then login
    Switch Virtual Account
    Choose Underlying    volidx  R_10
    Buy Touch No Touch Contract     2   minutes     +0.3
    View contract on trading page
    Check touch or no touch
    Capture page screenshot         screenshots/touchnotouch.png
    [Teardown]    Close Browser
