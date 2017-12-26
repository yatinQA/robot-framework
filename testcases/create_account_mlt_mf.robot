*** Settings ***
Documentation       A test suite with a single test for creating MLT-MF account.
...
...                 This test has a workflow that is created using keywords in
...                 the imported resource file.
Resource            ../common/resource.robot
Resource	        ../common/create_account_resource.robot
Library 	        OperatingSystem


*** Variables ***
${country}	          Austria
${country_id}		  at
${currency_fiat}      EUR

*** Test Cases ***
Create MLT-MF Account
    Prepare Endpoint Environment
    Create Virtual Account  ${country_id}

    #Click Link	btn_login
    #Set Selenium Speed    ${DELAY}
    #Login Page Should Be Open
    #Valid Login With Email ID    test_qa_id_77@binary.com  Binary@1
    #Wait Until Page Contains	Portfolio   30
    #Wait Until Page Contains	Open a Real Account	30
	#click open a real account
    #Click Element	xpath=//*[@id="topbar-msg"]/a/span

    #Create Standard Real Money Account
    Wait Until Page Contains	Family name   30
    ${random_first_name}=	Generate Random String	5	[LETTERS]
    set global variable   ${first_name}     test-mlt-${random_first_name}
    Sleep   5
    Input Fields for MX Real Money Account Opening		${first_name}
    Click Element	xpath=//*[@id="frm_real"]/div/button
    Sleep  5
    Page Should Contain   Sorry, you are too young to open an account

    #Update birthdate to be able to open account
    Scroll Page To Top
    Sleep  5
    Set Birth Date   1983  Jul
    Scroll Page To Middle
    Click Element	xpath=//*[@id="frm_real"]/div/button
    Sleep  5
    wait until element is visible   xpath=//*[@id="${currency_fiat}"]   60
    #Reality Check
    click element   xpath=//*[@id="reality_check_nav"]/button
    Page Should Contain    You have successfully created your account!
    capture page screenshot   screenshots/create_MLT_acc.png
    #Set Currency   ${currency_fiat}
    wait until page contains  Gaming Account   30

    #upgrade to MF account
    scroll page to top
    wait until page contains element   xpath=//*[@id="topbar-msg"]/a/span   30
    sleep    5
    click element   xpath=//*[@id="topbar-msg"]/a/span
    wait until page contains element   tax_identification_number   30
    input text   tax_identification_number   ${tax_id}
    Answer Financial Information
    press key   id=not_pep  \\09
    Select Checkbox	not_pep
    #Professional Request
    press key   id=chk_professional  \\09
    press key   id=professional_info_toggle   \\09
    Select Checkbox	tnc
    Execute Javascript  window.scrollTo(0,2850);
    Click Element	xpath=//*[@id="financial-form"]/div/button
    Sleep  5
    click element   xpath=//*[@id="financial-risk"]/fieldset/div/p[4]/button
    wait until element is visible   xpath=//*[@id="${currency_fiat}"]   30
    #Reality Check
    #sleep  5
    #click element   xpath=//*[@id="reality_check_nav"]/button
    Page Should Contain    You have successfully created your account!
    capture page screenshot   screenshots/create_MLT_MF_acc.png
    #Set Currency   ${currency_fiat}
    wait until page contains  Investment Account   30
    [Teardown]    Close Browser