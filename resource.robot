*** Settings ***
Documentation     A resource file with reusable keywords and variables.
...
...               The system specific keywords created here form our own
...               domain specific language. They utilize keywords provided
...               by the imported Selenium2Library.
Library		  String
Library           Selenium2Library

*** Variables ***
${BROWSER}        Chrome 
${DELAY}          0
${VALID USER}     munsei+cr@binary.com
${VALID PASSWORD}    Password1!
${HOME URL}      https://staging.binary.com/en/home.html
@{chrome_arguments}	--disable-infobars    --headless    --disable-gpu

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
    # Open Browser    ${HOME URL}    ${BROWSER}
    Chrome Headless
    Go To   ${HOME URL}
    Click Link	btn_login
    Set Selenium Speed    ${DELAY}
    Login Page Should Be Open

Login Page Should Be Open
    Page Should Contain   Log in using your email address

#Go To Login Page
#    Go To    ${LOGIN URL}
#    Login Page Should Be Open

Input Username
    [Arguments]    ${username}
    Input Text    txtEmail    ${username}

Input Password
    [Arguments]    ${password}
    Input Text    txtPass    ${password}

Submit Credentials
    Click Button    login

Valid Login
    Open Browser To Login Page
    Input Username	${VALID USER} 
    Input Password	${VALID PASSWORD}
    Submit Credentials
    Wait Until Page Contains	Portfolio   10

Switch Virtual Account
    Sleep  10 
    Click Element	css=div.account-id
    Click Element	css=div>a>li
    Wait Until Page Contains	Portfolio   10
    


