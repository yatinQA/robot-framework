*** Settings ***
Documentation     A test suite with test for asian contract
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
Buy asian contract
    Open xvfb browser then login
    Switch Virtual Account
    Choose Underlying    volidx  R_10
    Buy Asians Contract     5
    Verify Tick Contract Result
    Capture page screenshot         screenshots/buy_contract_asian.png
    [Teardown]    Close Browser
