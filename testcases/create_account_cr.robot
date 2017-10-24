*** Settings ***
Documentation     A test suite with a single test for creating CR account.
...
...               This test has a workflow that is created using keywords in
...               the imported resource file.
Resource          ../common/resource.robot
Resource	  ../common/create_account_resource.robot
Library 	      OperatingSystem


*** Variables ***
${country}	          Indonesia
${country_id}		  id
${currency_fiat}      EUR

*** Test Cases ***
Create CR Account
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

    Wait Until Page Contains	Family name	30
    ${random_first_name}=	Generate Random String	5	[LETTERS]
    set global variable   ${first_name}           test-cr-${random_first_name}
    Sleep   5
    Verify CR Real Money Account Opening Fields
    Input Fields for CR Real Money Account Opening		${first_name}
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
    Page Should Contain    You have successfully created your account!
    capture page screenshot   screenshots/create_CR_acc.png
    Set Currency   ${currency_fiat}
    wait until page contains  ${currency_fiat} Account   30
    [Teardown]    Close Browser