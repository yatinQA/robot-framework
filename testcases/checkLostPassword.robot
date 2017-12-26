
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
${EMAIL_LOST}       ridhotest@mailinator.com
${token_url}        https://staging.binary.com/en/redirect.html?action=reset_password=EN&code=
${mailinator_URL}   https://www.mailinator.com/v2/inbox.jsp?zone=public&query=ridhotest#/#msgpane
${NewPass}          Test1234
${latest_pass}
*** Keywords ***

Check email validation

    click button    btn_submit
    wait until element is visible   xpath=//*[@id="frm_lost_password"]/fieldset/div[1]/div[2]/p     2
    input text      email       ${INV_INPUT}
    element should be visible   xpath=//*[@id="frm_lost_password"]/fieldset/div[1]/div[2]/p
    element text should be   xpath=//*[@id="frm_lost_password"]/fieldset/div[1]/div[2]/p      Invalid email address
    reload page
    sleep    5
    input text      email       ridhotest@mailinator.com
    click button    btn_submit
    wait until element is visible   xpath=//*[@id="frm_lost_password"]/div      10
    page should contain   Please check your email for the password reset link.


Get verification Link

    go to  ${mailinator_URL}
    sleep   5
    wait until element is visible   xpath=(//DIV[@class='all_message-min_text all_message-min_text-3'][text()='Binary.com New Password Request'])[1]
                                    ...  5
    click element  xpath=(//DIV[@class='all_message-min_text all_message-min_text-3'][text()='Binary.com New Password Request'])[1]
    sleep       5
    select frame        xpath= //iframe[@id='msg_body']
    ${verification_url}=   Get Text   xpath=//*[@id="templateBody"]/tbody/tr/td/p[3]/a
    ${token} =	Get Substring	${verification_url}	  -8
    ${lostPass_url} =	Set Variable   ${token_url}${token}
    Go To   ${lostPass_url}


Check Pasword Reset Validation

    wait until page contains      Password Reset        10
    wait until page contains element        xpath=//*[@id="frm_reset_password"]
    #verify required fields
    select checkbox     have_real_account
    element should be visible       xpath=//*[@id="dob_field"]
    click button           btn_submit
    element should be visible       xpath=//*[@id="frm_reset_password"]/fieldset/div[1]/div[2]/p[2]
    element should be visible       xpath=//*[@id="frm_reset_password"]/fieldset/div[2]/div[2]/p
    element should be visible       xpath=//*[@id="dob_field"]/div[2]/p
    #verify invalid password
    input text      new_password        ${min_input}
    element text should be          xpath=//*[@id="frm_reset_password"]/fieldset/div[1]/div[2]/p[2]     You should enter 6-25 characters.
    input text     new_password     ${INV_INPUT}
    element text should be          xpath=//*[@id="frm_reset_password"]/fieldset/div[1]/div[2]/p[2]     Password should have lower and uppercase letters with numbers.
    input text    new_password      ${NewPass}
    input text    repeat_password   ${INV_INPUT}
    element text should be      xpath=//*[@id="frm_reset_password"]/fieldset/div[2]/div[2]/p    The two passwords that you entered do not match.


Verify DOB validation for Real Account
    log to console      DOB is required for Real Account
    unselect checkbox   have_real_account
    input text    new_password      ${NewPass}
    input text    repeat_password      ${NewPass}
    click button  btn_submit
    wait until page contains    Date of birth is required. Please click the link below to restart the password recovery process.    10
Valid reset password
    click link          xpath= //*[@id="form_error"]/a
    sleep    3
    input text      email       ridhotest@mailinator.com
    click button    btn_submit
    Get verification Link
    select checkbox   have_real_account
    click element   date_of_birth
    select from list by value       xpath=//*[@class="ui-datepicker-month"]     11
    select from list by value       xpath=//*[@class="ui-datepicker-year"]       1999
    click element       xpath=//*[@id="ui-datepicker-div"]/table/tbody/tr[2]/td[4]/a
    ${add_randomString}     generate random string      4       abcdef
    ${latest_pass}     set variable         ${NewPass}${add_randomString}
    set global variable  ${latest_pass}
    input text    new_password         ${latest_pass}
    input text    repeat_password      ${latest_pass}

    click button  btn_submit
    wait until page contains    Your password has been successfully reset. Please log into your account using your new password.        10

Login with the new password

    Open Login page in xvfb browser
    Input Username	 ${EMAIL_LOST}
    Input Password	  ${latest_pass}
    Submit Credentials
    ${GRANT} =          run keyword and return status  page should not contain   Review Permissions
    run keyword if   ${GRANT}!=1    Grant Permission
    Wait Until Page Contains	Portfolio   10
    sleep  3

*** Test Cases ***
Check Lost Password Page
    open browser and then go to lost password page
    check email validation
    get verification link
    check pasword reset validation
    verify dob validation for real account
    valid reset password
    login with the new password
    capture page screenshot
    [Teardown]    Close Browser
