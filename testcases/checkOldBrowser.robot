*** Settings ***
Documentation     A test suite with a single test for checking Older browser
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
${Opera}       (Opera 41)

*** Keywords ***

Check warning message

    wait until page contains    The easiest way to get started in the financial markets     10
     [Arguments]      ${browser}
    page should contain      Your web browser ${browser} is out of date and may affect your trading experience. Proceed at your own risk.


*** Test Cases ***
Verifiy message in Old Firefox
    Open Binary Site    BROWSER=Firefox  BROWSER_VERSION=51.0  OS=Windows  OS_VERSION=10
    sleep    ${Delay}
    check warning message   ${Firefox}
    [Teardown]    Close Browser

Verifiy message in Old Chrome
    Open Binary Site    BROWSER=Chrome  BROWSER_VERSION=49.0  OS=OS X  OS_VERSION=Sierra
    sleep    ${Delay}
    check warning message    ${Chrome}
    [Teardown]    Close Browser

Verifiy message in Old Safari
    Open Binary Site    BROWSER=Safari  BROWSER_VERSION=8.0  OS=OS X  OS_VERSION=Yosemite
    sleep    ${Delay}
    check warning message    ${Safari}
    [Teardown]    Close Browser

