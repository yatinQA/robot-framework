
*** Settings ***
Documentation     A test suite with a single test for checking change password page
...
...               This test has a workflow that is created using keywords in
...               the imported resource file.
Resource          ../common/resource.robot
Resource          ../common/navigation.robot

*** Variables ***



*** Keywords ***
Navigate to change password

    Navigate to setting&security
    wait until element is visible   xpath=//*[@id="change_password"]/div[1]/a
    wait until element is visible   xpath=//*[@id="change_password"]/div[1]/a
    click element                   xpath=//*[@id="change_password"]/div[1]/a


Verify the page is loaded successfuly

    wait until element is visible           xpath=//*[@id="content"]/div[2]/h1
    wait until element is visible           xpath=//*[@id="content"]

Verify required fields

    click button              xpath=//*[@id="btn_submit"]
    element text should be    xpath=//*[@id="frm_change_password"]/fieldset/div[1]/div[2]/div                   ${REQUIRED_FIELD_MSG}
    element text should be    xpath=//*[@id="frm_change_password"]/fieldset/div[2]/div[2]/div[2]                ${REQUIRED_FIELD_MSG}
    element text should be    xpath=//*[@id="frm_change_password"]/fieldset/div[3]/div[2]/div                   ${REQUIRED_FIELD_MSG}

Verify invalid input

    input text                      old_password                                                                ${MIN_INPUT}
    element text should be          xpath=//*[@id="frm_change_password"]/fieldset/div[1]/div[2]/div             ${MIN_INPUT_MSG}
    clear element text              old_password
    input text                      new_password                                                                ${MIN_INPUT}
    element text should be          xpath=//*[@id="frm_change_password"]/fieldset/div[2]/div[2]/div[2]          ${MIN_INPUT_MSG}
    clear element text              new_password
    input text                      new_password                                                                 ${INV_INPUT}
    element text should be          xpath=//*[@id="frm_change_password"]/fieldset/div[2]/div[2]/div[2]           ${PASS_REQUIREMENT_MSG}
    clear element text              new_password
    input text                      old_password                                                                 ${VALID_PASS}
    input text                      new_password                                                                 ${VALID_PASS}
    element text should be          xpath=//*[@id="frm_change_password"]/fieldset/div[2]/div[2]/div[2]           ${SAME_PASSWORD_MSG}
    clear element text              old_password
    clear element text              new_password
    input text                      new_password                                       ${VALID_PASS}
    input text                      repeat_password                                    ${MIN_INPUT}
    element text should be          xpath=//*[@id="frm_change_password"]/fieldset/div[3]/div[2]/div                                   ${UNMATCH_PASS_MSG}
    clear element text              new_password
    clear element text              repeat_password
    input text                      old_password                                        ${VALID_PASS}
    input text                      new_password                                        ${VALID PASSWORD}
    input text                      repeat_password                                     ${VALID PASSWORD}
    click button                    xpath=//*[@id="btn_submit"]
    wait until element is visible   xpath=//*[@id="form_error"]
    element text should be          xpath=//*[@id="form_error"]                       ${INV_OLD_PASSWORD}

Verify Change Password
    clear element text              old_password
    clear element text              new_password
    clear element text              repeat_password
    input text                      old_password                                        ${VALID PASSWORD}
    input text                      new_password                                        ${VALID_PASS}
    input text                      repeat_password                                     ${VALID_PASS}
    click button                    xpath=//*[@id="btn_submit"]
    wait until element is visible   xpath=//*[@id="msg_success"]
    element text should be          xpath=//*[@id="msg_success"]                     ${SUCCESS_CHANGED_PASSWORD_MSG}
    wait until element is visible   xpath=//*[@id="frmLogin"]/div[3]/button     12

Valid login after session destroyed
    Input Username	${VALID USER}
    Input Password	${VALID_PASS}
    Submit Credentials
    page should not contain     Incorrect email or password.

Change Password to original password
    clear element text              old_password
    clear element text              new_password
    clear element text              repeat_password
    input text                      old_password                                        ${VALID_PASS}
    input text                      new_password                                        ${VALID PASSWORD}
    input text                      repeat_password                                     ${VALID PASSWORD}
    click button                    xpath=//*[@id="btn_submit"]
    wait until element is visible   xpath=//*[@id="msg_success"]
    element text should be          xpath=//*[@id="msg_success"]                      ${SUCCESS_CHANGED_PASSWORD_MSG}

*** Test Cases ***
Check Changed Password Page
    Valid Login
    Navigate to change password
    verify the page is loaded successfuly
    verify required fields
    verify invalid input
    verify change password
    valid login after session destroyed
    navigate to change password
    verify the page is loaded successfuly
    change password to original password
    capture page screenshot         screenshots/changepassword.png
    [Teardown]    Close Browser
