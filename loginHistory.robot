*** Settings ***
Documentation     A test suite with a single test for buying Up/Down Rise/Fall contract.
...
...               This test has a workflow that is created using keywords in
...               the imported resource file.
Resource          resource.robot

*** Keywords ***
Verify login Success
    ${success}    Get Text    xpath=//*[@id="login-history-table"]/tbody/tr[1]/td[5]
    should be equal as strings        ${success}         Successful

Verify login Failed
    ${failed}    Get Text    xpath=//*[@id="login-history-table"]/tbody/tr[2]/td[5]
    should be equal as strings        ${failed}         Failed
*** Test Cases ***
Check Login History Page
    Invalid Login
    Valid Login
    Navigate to setting&security
    wait until element is visible  xpath=//*[@id="settings_container"]/div/div[5]/div[2]/h4/a
    click element                   xpath=//*[@id="settings_container"]/div/div[5]/div[1]/a
    Wait Until Element Is Visible	xpath=//*[@id="login_history-title"]/h1
    wait until element is visible   xpath=//*[@id='login-history-table']
    verify login success
    verify login failed
    page should contain             Login History
    [Teardown]    Close Browser
