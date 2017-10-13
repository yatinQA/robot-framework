
*** Settings ***
Documentation     A test suite with a single test for personal details page
...
...               This test has a workflow that is created using keywords in
...               the imported resource file.
Resource          ../common/resource.robot
Resource          ../common/navigation.robot
Library            String


*** Variables ***
${error_msg}               This field is required.


*** Keywords ***
Navigate to financial assessment page

    navigate to profile
    wait until element is visible   xpath=//*[@id="settings_container"]/div/div[1]/div[1]/a
    click element                   link=Financial Assessment

Verify the page is loaded successfully

    sleep  5
    wait Until Page Contains	Financial Information	60

Verify number of errors

    sleep  5
    Xpath should match X Times     //div[@class="error-msg"]        21
    element text should be         //div[@class="error-msg"]        This field is required.

*** Test Cases ***
Check Financial Assessment Fields
    Open xvfb browser then login
    Navigate to financial assessment page
    Verify the page is loaded successfully
    Click element   id=btn_submit
    Verify number of errors
    capture page screenshot         screenshots/financialAssessment.png
    [Teardown]    Close Browser