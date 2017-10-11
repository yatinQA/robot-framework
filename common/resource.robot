*** Settings ***
Documentation     A resource file with reusable keywords and variables.
...
...               The system specific keywords created here form our own
...               domain specific language. They utilize keywords provided
...               by the imported Selenium2Library.
Library		      String
Library           Selenium2Library 

*** Variables ***
#THESE ARE BROWSER VARIBALES
${BROWSER}        Chrome 
${DELAY}          0
${VALID USER}     ridho+jp@binary.com
${VALID PASSWORD}    Abcd1234
${HOME URL}      https://staging.binary.com/en/home.html
${ENDPOINT URL}  https://staging.binary.com/en/endpoint.html
@{chrome_arguments}	--disable-infobars    --headless    --disable-gpu

#THESE ARE GLOBAL VARIABLES

${MIN_INPUT}                     aaa
${INV_INPUT}                     aaaaaaaaaa
${VALID_PASS}                    Abcd12345
${REQUIRED_FIELD_MSG}            This field is required.
${CASHIER_LOCKED_MSG}            Your cashier is locked as per your request - to unlock it, please enter the password.
${MIN_INPUT_MSG}                 You should enter 6-25 characters.
${PASS_REQUIREMENT_MSG}          Password should have lower and uppercase letters with numbers.
${UNMATCH_PASS_MSG}              The two passwords that you entered do not match.
${DIFF_PASS_MSG}                 Please use a different password than your login password.
${SUCCESS_MSG}                   Your settings have been updated successfully.
${CHECK_LOCKED_CASHIER_MSG}      Your cashier is locked as per your request - to unlock it, please click here.
${SAME_PASSWORD_MSG}             Current password and New password cannot be the same.
${INV_OLD_PASSWORD}              Old password is wrong.
${SUCCESS_CHANGED_PASSWORD_MSG}  Your password has been changed. Please log in again.
${SCOPE_REQUIRED_MSG}            Please select at least one scope
${INV_CHAR_INPUT}                &%%&^%&^%:/'{}[
${INV_CHAR_INPUT_MSG}            Only letters, numbers, space, _ are allowed.
${TOKEN_NAME_INPUT}              Binary Token
${NAME_TAKEN_MSG}                The name is taken.
${TOKEN_NAME_INPUT}              Duplicate Binary Token

*** Keywords ***
Set Chrome Options
    [Documentation]    Set Chrome options for headless mode
    ${options}=    Evaluate    sys.modules['selenium.webdriver'].ChromeOptions()    sys, selenium.webdriver
    : FOR    ${option}    IN    @{chrome_arguments}
    \    Call Method    ${options}    add_argument    ${option}
    [Return]    ${options}

Chrome Headless
    ${chrome_options}=    Set Chrome Options
    Create Webdriver    Chrome    chrome_options=${chrome_options}

Open Browser To Login Page
    # Start Virtual Display

    #Open Browser    ${HOME URL}    ${BROWSER}
    Chrome Headless
    Go To   ${HOME URL}
    Click Link	btn_login
    Set Selenium Speed    ${DELAY}
    Login Page Should Be Open

Login Page Should Be Open
    Page Should Contain   Log in using your email address

Input Username
    [Arguments]    ${username}
    Input Text    txtEmail    ${username}

Input Password
    [Arguments]    ${password}
    Input Text    txtPass    ${password}

Submit Credentials
    wait until element is visible   login
    Click Button    login

Grant Permission
    click button  confirm_scopes

Valid Login
    Open Browser To Login Page
    Input Username	${VALID USER}
    Input Password	${VALID PASSWORD}
    Submit Credentials
    ${GRANT} =          run keyword and return status  page should not contain   Review Permissions
    run keyword if   ${GRANT}!=1    Grant Permission
    Wait Until Page Contains	Portfolio   10

Valid Login With Email ID
    [Arguments]	  ${email_id}   ${user_password}
    Input Username	${email_id}
    Input Password	${user_password}
    Submit Credentials
    ${GRANT} =          run keyword and return status  page should not contain   Review Permissions
    run keyword if   ${GRANT}!=1    Grant Permission
    Wait Until Page Contains	Portfolio   10

Invalid Login
    Open Browser To Login Page
    Input Username	${VALID USER}
    Input Password	Invalid Password
    Submit Credentials
    close browser

Switch Virtual Account
    Sleep  10
    Click Element	css=div.account-id
    Click Element	css=div>a>li
    Wait Until Page Contains	Portfolio   10

Open xvfb browser then login
    Open Browser    ${HOME URL}    ${BROWSER}
    Go To   ${HOME URL}
    wait until element is visible  btn_login
    Click Link	btn_login
    Set Selenium Speed    ${DELAY}
    Login Page Should Be Open
    Input Username	${VALID USER}
    Input Password	${VALID PASSWORD}
    Submit Credentials
    ${GRANT} =          run keyword and return status  page should not contain   Review Permissions
    run keyword if   ${GRANT}!=1    Grant Permission
    Wait Until Page Contains	Portfolio   10

Set Endpoint
    [Arguments]	  ${server}   ${oauth_app_id}
    Chrome Headless
    Go To   ${ENDPOINT URL}
    #Open Browser    ${ENDPOINT URL}    ${BROWSER}
    Input Text	 server_url    ${server}
    Input Text   app_id	       ${oauth_app_id}
    Click Button   new_endpoint


