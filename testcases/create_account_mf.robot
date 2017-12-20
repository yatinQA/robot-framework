*** Settings ***
Documentation       A test suite with a single test for creating MF account.
...
...                 This test has a workflow that is created using keywords in
...                 the imported resource file.
Resource            ../common/resource.robot
Resource	        ../common/create_account_resource.robot
Library 	        OperatingSystem


*** Variables ***
${country}	          Spain
${country_id}		  es
${currency_fiat}      EUR

*** Test Cases ***
Create MF Account
    Prepare Endpoint Environment
    Create Virtual Account  ${country_id}
    Create Standard Real Money Account
    Wait Until Page Contains	Family name   30
    ${random_first_name}=	Generate Random String	5	[LETTERS]
    set global variable   ${first_name}     test-mf-${random_first_name}
    Sleep   5
    Input Fields for MF Real Money Account Opening		${first_name}
    click element   xpath=//*[@id="financial-form"]/div/button
    Sleep  5
    Page Should Contain   Sorry, you are too young to open an account

    #Update birthdate to be able to open account
    Scroll Page To Top
    Sleep  10
    Set Birth Date   1983  Jul
    press key   id=tnc   \\09
    Click Element	xpath=//*[@id="financial-form"]/div/button
    Sleep  5
    click element   xpath=//*[@id="financial-risk"]/fieldset/div/p[4]/button
    wait until element is visible   xpath=//*[@id="${currency_fiat}"]   60
    #Reality Check
    sleep  5
    click element   xpath=//*[@id="reality_check_nav"]/button
    Page Should Contain    You have successfully created your account!
    capture page screenshot   screenshots/create_MF_acc.png
    Set Currency   ${currency_fiat}
    wait until page contains  Investment Account   30
    [Teardown]    Close Browser
