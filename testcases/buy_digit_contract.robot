*** Settings ***
Documentation     A test suite with test for digit contract
...
...               This test has a workflow that is created using keywords in
...               the imported resource file.
Resource          ../common/resource.robot
Resource          ../common/contract_resource.robot
Resource          ../common/navigation.robot
Library           String
Library           Collections
Library           DateTime

*** Variables ***


*** Keywords ***




*** Test Cases ***
Check Match/Differ Contract
    Open xvfb browser then login
    Switch Virtual Account
    Choose Underlying    volidx  R_10
    buy a digit contract    5   ticks     1     matchdiff
    Verify Tick Contract Result
    check last digit
    capture page screenshot
    [Teardown]    Close Browser


Check Over / Under Contract
    Open xvfb browser then login
    Switch Virtual Account
    Choose Underlying    volidx  R_10
    buy a digit contract    5   ticks     1     overunder
    Verify Tick Contract Result
    check last digit
    capture page screenshot
    [Teardown]    Close Browser


Check Even / Odd contract
    Open xvfb browser then login
    Switch Virtual Account
    Choose Underlying    volidx  R_10
    buy a digit-even/odd contract    5   ticks    evenodd   10
    Verify Tick Contract Result
    check last digit
    capture page screenshot
    [Teardown]    Close Browser
