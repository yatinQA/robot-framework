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


   click button                    xpath=.//*[@id='applications-table']/tbody/tr[contains(.,'Binary-Staging')]/td[4]/button
   sleep     2
   confirm action
Login after revoke
    Open Browser    ${HOME URL}    ${BROWSER}
    Go To   ${HOME URL}
    wait until element is visible  btn_login
    Click Link	                   btn_login
    Set Selenium Speed            ${DELAY}
    Input Username	               ${VALID USER}
    Input Password	               ${VALID PASSWORD}
    Click Button                   login

Cancel Scope
    wait until element is visible    xpath=//*[@id="wrapper"]/div[2]/form/div/button[2]
    click button                     xpath=//*[@id="wrapper"]/div[2]/form/div/button[2]
    wait until element is visible    btn_login
    Click Link	                     btn_login
verify authorise page
    wait until element is visible  xpath=//*[@id="wrapper"]/div[2]/h1
    wait until page contains       Review Permissions

Verify grant process

    Set Selenium Speed             ${DELAY}
    Input Username	               ${VALID USER}
    Input Password	               ${VALID PASSWORD}
    Click Button                   login
    verify authorise page
    click button                   confirm_scopes

*** Test Cases ***
Check Authorised Application Page
    Open xvfb browser then login
    Navigate to authorised page
    verify staging app
    verify revoke
    close browser
    login after revoke
    cancel scope
    verify grant process
    navigate to authorised page
    verify staging app
    capture page screenshot         screenshots/cashierPass.png
    [Teardown]    Close Browser