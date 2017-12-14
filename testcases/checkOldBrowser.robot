*** Settings ***
Documentation     A test suite with a single test for checking Older browsers
...
Resource          ../common/setup.robot
Library           Selenium2Library
Library           OperatingSystem
Suite Teardown    Close Browser
Force Tags       BrowserStack

*** Variables ***

${Chrome}      (Chrome 49)
${Firefox}     (Firefox 51)
${Safari}      (Safari 8)
#we are unable to check opera because of its not available in Automate browser.
${Opera}       (Opera 41)
${IE11}        (Internet Explorer 11)

*** Keywords ***

Check warning message

    wait until page contains    The easiest way to get started in the financial markets     10
    [Arguments]      ${browser}
    page should contain      Your web browser ${browser} is out of date and may affect your trading experience. Proceed at your own risk.


Check home page

    wait until page contains        Log in
    wait until element is visible   xpath=//*[@id="btn_login"]
    click element                   xpath=//*[@id="mobile-menu-icon"]
    element should be visible       xpath=//*[@id="mm-m0-p0"]/li[1]/a
    element should be visible       mobile-menu


*** Test Cases ***
Verify message in Old Firefox
    Open Binary Site    BROWSER=Firefox  BROWSER_VERSION=51.0  OS=Windows  OS_VERSION=10
    sleep    ${Delay}
    check warning message   ${Firefox}
    [Teardown]    Close Browser

Verify message in Old Chrome
    Open Binary Site    BROWSER=Chrome  BROWSER_VERSION=49.0  OS=OS X  OS_VERSION=Sierra
    sleep    ${Delay}
    check warning message    ${Chrome}
    [Teardown]    Close Browser

Verify message in Old Safari
    Open Binary Site    BROWSER=Safari  BROWSER_VERSION=8.0  OS=OS X  OS_VERSION=Yosemite
    sleep    ${Delay}
    check warning message    ${Safari}
    [Teardown]    Close Browser

Verifiy message in IE
    Open Binary Site    BROWSER=IE  BROWSER_VERSION=11.0  OS=Windows  OS_VERSION=7
    sleep    ${Delay}
    check warning message    ${IE11}
    [Teardown]    Close Browser


verify page is working in IOS 10

    open binary site  DEVICE=iPhone 7  REALDEVICE=true    OS_VERSION=10.0
    sleep    ${Delay}
    check home page
    [Teardown]    Close Browser