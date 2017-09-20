
*** Settings ***
Documentation     A test suite with a single test for checking cashier password page
...
...               This test has a workflow that is created using keywords in
...               the imported resource file.
Resource          ../common/resource.robot

*** Variables ***
${MIN_INPUT}        aaa
${INV_INPUT}        aaaaaaaaaa
${VALID_PASS}       Abcd12345


*** Keywords ***
Verify required fields
    ${unlock}=                 run keyword and return status        element text should be         //*[@id="lockInfo"]        Your cashier is locked as per your request - to unlock it, please enter the password.
    run keyword if               ${unlock}   Unlock cashier
    click button              xpath=//*[@id="btn_submit"]
    element text should be    xpath=//*[@id="frm_cashier_password"]/fieldset/div[2]/div[2]/div[2]       This field is required.
    element text should be    xpath=//*[@id="repeat_password_row"]/div[2]/div                           This field is required.

Verify invalid input

    input text                      xpath=//*[@id='cashier_password']                                        ${MIN_INPUT}
    element text should be          xpath=//*[@id='frm_cashier_password']/fieldset/div[2]/div[2]/div[2]      You should enter 6-25 characters.
    clear element text              xpath=//*[@id='cashier_password']
    input text                      xpath=//*[@id='cashier_password']                                         ${INV_INPUT}
    element text should be          xpath=//*[@id='frm_cashier_password']/fieldset/div[2]/div[2]/div[2]      Password should have lower and uppercase letters with numbers.
    clear element text              xpath=//*[@id='cashier_password']
    input text                      xpath=//*[@id='cashier_password']                                          ${VALID_PASS}
    input text                      xpath=//*[@id="repeat_cashier_password"]                                   ${MIN_INPUT}
    element text should be          xpath=//*[@id='repeat_password_row']/div[2]/div                          The two passwords that you entered do not match.
    clear element text              xpath=//*[@id='cashier_password']
    clear element text              xpath=//*[@id="repeat_cashier_password"]
    input text                      xpath=//*[@id='cashier_password']                                           ${VALID PASSWORD}
    input text                      xpath=//*[@id="repeat_cashier_password"]                                    ${VALID PASSWORD}
    click button                    xpath=//*[@id="btn_submit"]
    wait until element is visible   xpath=//*[@id="form_error"]
    element text should be          xpath=//*[@id="form_error"]                                           Please use a different password than your login password.

Lock cashier
    clear element text              xpath=//*[@id='cashier_password']
    clear element text              xpath=//*[@id="repeat_cashier_password"]
    input text                      xpath=//*[@id='cashier_password']                                            ${VALID_PASS}
    input text                      xpath=//*[@id="repeat_cashier_password"]                                     ${VALID_PASS}
    click button                    xpath=//*[@id="btn_submit"]
    wait until element is visible   xpath=//*[@id="form_message"]
    element text should be          xpath=//*[@id="form_message"]                     Your settings have been updated successfully.

Verify Locked Cashier

    click button                    xpath=//*[@id="content"]/div[2]/div[3]/div/div[3]/div[1]/a/span
    element text should be          xpath=//*[@id="cashier_locked_message"]         Your cashier is locked as per your request - to unlock it, please click .
    go back
    click button                    xpath=//*[@id="content"]/div[2]/div[3]/div/div[3]/div[2]/a/span
    element text should be          xpath=//*[@id="cashier_locked_message"]         Your cashier is locked as per your request - to unlock it, please click .

Unlock cashier

    wait until page contains        Unlock Cashier
    input text                      xpath=//*[@id="cashier_password"]     ${VALID_PASS}
    click button                    xpath=//*[@id="btn_submit"]

*** Test Cases ***
Check Cashier Page
    Valid Login
    Navigate to setting&security
    wait until element is visible   xpath=//*[@id="settings_container"]/div/div[2]/div[1]/a/img
    click element                   xpath=//*[@id="settings_container"]/div/div[2]/div[1]/a
    Wait Until Element Is Visible	xpath=//*[@id="content"]/div[2]/h1
    wait until element is visible   xpath=//*[@id="frm_cashier_password"]/fieldset
    verify required fields
    verify invalid input
    lock cashier
    navigate to cashier page
    verify locked cashier
    capture page screenshot         screenshots/cashierPass.png
    page should contain             Lock Cashier
    [Teardown]    Close Browser


