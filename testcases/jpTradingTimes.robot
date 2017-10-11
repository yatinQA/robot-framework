
*** Settings ***
Documentation     A test suite with a single test for checking JP Trading Times page
...
...               This test has a workflow that is created using keywords in
...               the imported resource file.
Resource          ../common/resource.robot
Resource          ../common/navigation.robot
Library            String
Library            Collections


*** Variables ***

*** Keywords ***
Navigate to trading times
    switch to jp
    Navigate to resources page
    wait until element is visible   xpath=//*[@id="content"]/div[2]/div/div[2]/div[1]/a
    click element                   xpath=//*[@id="content"]/div[2]/div/div[2]/div[1]/a


Verify the page is loaded successfuly

    sleep  5
    wait until element is visible           xpath=//*[@id="market_1"]/div/div
    wait until element is visible           xpath=//*[@id="content"]/div[2]/p[2]




*** Test Cases ***
Check JP trading Times Page
    open xvfb browser then login
    Navigate to trading times
    verify the page is loaded successfuly
    capture page screenshot         screenshots/changepassword.png
    [Teardown]    Close Browser
