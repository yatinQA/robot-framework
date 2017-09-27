
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
   sleep     5
   wait until element is visible   login
   Input Username	               ${VALID USER}
   Input Password	               ${VALID PASSWORD}
   Click Button                    login

Login after cancel
    Click Link	                   btn_login
    Input Username	               ${VALID USER}
    Input Password	               ${VALID PASSWORD}
    Click Button                   login

verify authorise page
    wait until element is visible  xpath=//*[@id="wrapper"]/div[2]/h1
    wait until page contains       Review Permissions

Verify grant process

    verify authorise page
    click button                   xpath=//*[@id="wrapper"]/div[2]/form/div/button[2]
    wait until element is visible  xpath=//*[@id="btn_login"]
    login after cancel
    verify authorise page
    click button                   confirm_scopes

*** Test Cases ***
Check Authorised Application Page
    Open xvfb browser then login
    Navigate to authorised page
    verify staging app
    verify revoke
    verify grant process
    verify staging app
    capture page screenshot         screenshots/cashierPass.png
    [Teardown]    Close Browser
