
*** Settings ***
Documentation     A test suite with a single test for checking cashier password page
...
...               This test has a workflow that is created using keywords in
...               the imported resource file.
Resource          ../common/resource.robot
Resource          ../common/navigation.robot

*** Variables ***



*** Keywords ***
Navigate to cashier password page

    Navigate to setting&security
    wait until element is visible   xpath=//*[@id="settings_container"]/div/div[2]/div[1]/a/img
    click element                   xpath=//*[@id="settings_container"]/div/div[2]/div[1]/a


Verify required fields

    ${unlock}=                run keyword and return status        element text should be         //*[@id="lockInfo"]        ${CASHIER_LOCKED_MSG}
    run keyword if            ${unlock}   Unlock cashier
    click button              xpath=//*[@id="btn_submit"]
    element text should be    xpath=//*[@id="frm_cashier_password"]/fieldset/div[2]/div[2]/p[2]               ${REQUIRED_FIELD_MSG}
    element text should be    xpath=//*[@id="repeat_password_row"]/div[2]/p                                   ${REQUIRED_FIELD_MSG}

Verify invalid input

    input text                      xpath=//*[@id='cashier_password']                                           ${MIN_INPUT}
    element text should be          xpath=//*[@id='frm_cashier_password']/fieldset/div[2]/div[2]/p[2]         ${MIN_INPUT_MSG}
    clear element text              xpath=//*[@id='cashier_password']
    input text                      xpath=//*[@id='cashier_password']                                           ${INV_INPUT}
    element text should be          xpath=//*[@id='frm_cashier_password']/fieldset/div[2]/div[2]/p[2]         ${PASS_REQUIREMENT_MSG}
    clear element text              xpath=//*[@id='cashier_password']
    input text                      xpath=//*[@id='cashier_password']                                           ${VALID_PASS}
    input text                      xpath=//*[@id="repeat_cashier_password"]                                    ${MIN_INPUT}
    element text should be          xpath=//*[@id='repeat_password_row']/div[2]/p                             ${UNMATCH_PASS_MSG}
    clear element text              xpath=//*[@id='cashier_password']
    clear element text              xpath=//*[@id="repeat_cashier_password"]
    input text                      xpath=//*[@id='cashier_password']                                           ${VALID PASSWORD}
    input text                      xpath=//*[@id="repeat_cashier_password"]                                    ${VALID PASSWORD}
    click button                    xpath=//*[@id="btn_submit"]
    wait until element is visible   xpath=//*[@id="form_error"]    10
    element text should be          xpath=//*[@id="form_error"]                                                  ${DIFF_PASS_MSG}

Lock cashier
    clear element text              xpath=//*[@id='cashier_password']
    clear element text              xpath=//*[@id="repeat_cashier_password"]
    input text                      xpath=//*[@id='cashier_password']                                            ${VALID_PASS}
    input text                      xpath=//*[@id="repeat_cashier_password"]                                     ${VALID_PASS}
    click button                    xpath=//*[@id="btn_submit"]
    wait until element is visible   xpath=//*[@id="form_message"]
    element text should be          xpath=//*[@id="form_message"]                                                ${SUCCESS_MSG}

Verify Locked Cashier

    #wait until element is visible   xpath=//*[@id="content"]/div[2]/div[4]
    wait until page contains	    Bank-wire, credit card, e-cash wallet
    click element                   xpath=//*[@id="deposit_btn_cashier"]/span
    wait until element is visible   xpath=//*[@id="cashier_locked_message"]
    element text should be          xpath=//*[@id="cashier_locked_message"]                                      ${CHECK_LOCKED_CASHIER_MSG}
    navigate to cashier page
    #wait until element is visible   xpath=//*[@id="content"]/div[2]/div[4]    10
    wait until page contains        Bank-wire, credit card, e-cash wallet   10
    click element                   id = deposit_btn_cashier
   # click element		     xpath=//*[@id="content"]/div[3]/div[4]/div/div[3]/div[2]/a/span
    #click element                   xpath=//*[@id="content"]/div[2]/div[4]/div/div[3]/div[2]/a/span
    wait until element is visible   xpath=//*[@id="cashier_locked_message"]
    element text should be          xpath=//*[@id="cashier_locked_message"]                                      ${CHECK_LOCKED_CASHIER_MSG}

Unlock cashier

    wait until page contains        Unlock Cashier
    input text                      xpath=//*[@id="cashier_password"]                                            ${VALID_PASS}
    click button                    xpath=//*[@id="btn_submit"]
    reload page
    wait until element is visible   xpath=//*[@id="frm_cashier_password"]/fieldset


*** Test Cases ***
Check Cashier Page
    open xvfb browser then login
    Navigate to cashier password page
    #Wait Until Element Is Visible	xpath=//*[@id="content"]/div[2]/h1
    wait until element is visible   xpath=//*[@id="frm_cashier_password"]/fieldset
    verify required fields
    verify invalid input
    lock cashier
    navigate to cashier page
    verify locked cashier
    Navigate to cashier password page
    unlock cashier
    capture page screenshot         screenshots/cashierPass.png
    page should contain             Lock Cashier
    [Teardown]    Close Browser
