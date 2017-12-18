*** Settings ***
Documentation     A test suite with a single test for buying Up/Down Rise/Fall contract.
...
...               This test has a workflow that is created using keywords in
...               the imported resource file.
Resource          ../common/resource.robot
Resource          ../common/contract_resource.robot

*** Variables ***
${profit_lost_evaluate}		0

*** Keywords ***


*** Test Cases ***
Trade Up Down
    Open xvfb browser then login
    Switch Virtual Account
    Choose Underlying    volidx  R_10
    Sleep   3
    Input Text  duration_amount  5
    Sleep   3
    Select From List	id=duration_units	ticks
    Wait Until Element Is Visible	purchase_button_bottom	10	
    Sleep   5
    Click Element	purchase_button_bottom	
    Wait Until Page Contains	This contract	60
    Capture Page Screenshot   screenshots/buy_contract_up_down.png
    Verify Tick Contract Result
    [Teardown]    Close Browser
