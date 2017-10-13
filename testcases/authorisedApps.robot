*** Settings ***
Documentation     A test suite with a single test for checking Authorised Application page
...
...               This test has a workflow that is created using keywords in
...               the imported resource file.
Resource          ../common/resource.robot
Resource          ../common/navigation.robot

*** Variables ***



*** Keywords ***

Navigate to authorised page

    Navigate to setting&security
    wait until element is visible   xpath=//*[@id="settings_container"]/div/div[7]/div[1]/a/img
    click element                   xpath=//*[@id="settings_container"]/div/div[7]/div[1]/a


Verify staging app

     Wait Until Element Is Visible	    xpath=//*[@id="applications-title"]/h1
     wait until element is visible      xpath=//*[@id="applications-table"]
     page should contain                Binary-Staging


Verify revoke

   Choose Ok On Next Confirmation
   click button                    xpath=.//*[@id='applications-table']/tbody/tr[contains(.,'Binary-Staging')]/td[4]/button
   confirm action

Login after revoke
    Open Browser    ${HOME URL}    ${BROWSER}
    Go To   ${HOME URL}
    wait until element is visible  btn_login
    Click Link	btn_login
    Set Selenium Speed    ${DELAY}
    Login Page Should Be Open
    Input Username	${VALID USER}
    Input Password	${VALID PASSWORD}
    Submit Credentials
    page should contain          Review Permissions
    grant permission
    Wait Until Page Contains	Portfolio   10


*** Test Cases ***
Check Authorised Application Page
    Open xvfb browser then login
    Navigate to authorised page
    verify staging app
    verify revoke
    close browser
    login after revoke
    navigate to authorised page
    verify staging app
    capture page screenshot         screenshots/authorisedApp.png
    [Teardown]    Close Browser
