*** Settings ***
Documentation     A test suite with a single test for creating CR account.
...
...               This test has a workflow that is created using keywords in
...               the imported resource file.
Resource          ../common/resource.robot
Library 	      OperatingSystem
Library		      DateTime
#Suite Teardown   Close All Connections

*** Variables ***
${ENDPOINT ADDRESS}   www.binaryqa10.com
${ENDPOINT APP ID}    1003
${HOST}               localhost
${email_url}          https://${ENDPOINT ADDRESS}/emails/
${email_subject}      Content-Transfer-Encoding
${token_url}          https://staging.binary.com/en/redirect.html?action=signup=EN&code=
${user_password}      Binary@1
${last_name}	      last
${account_opening_reason}	Speculative
${address_line_1}	123 Abc
${address_city}		Abc City
${phone}	      	+62456787612
${secret_answer}	test answer
${row}              2

*** Keywords ***
Scroll Page To Middle
    Execute Javascript	window.scrollTo(0,document.body.scrollHeight/2);

Scroll Page To Bottom
    Execute Javascript	window.scrollTo(0,document.body.scrollHeight);

Scroll Page To Top
    Execute Javascript	window.scrollTo(0,0);

Prepare Endpoint Environment
    Set Endpoint   ${ENDPOINT ADDRESS}   ${ENDPOINT APP ID}
    Click Element  xpath=//a[@id='logo']/div/div[2]/div
    Wait Until Element Is Visible   btn_verify_email
    Sleep  5

Prepare Endpoint Environment Xvfb
    Set Endpoint Xvfb  ${ENDPOINT ADDRESS}   ${ENDPOINT APP ID}
    Click Element  xpath=//a[@id='logo']/div/div[2]/div
    Wait Until Element Is Visible   btn_verify_email
    Sleep  5

Retrieve Token
    Go To   ${email_url}
    ${count}=   Get Matching Xpath Count    //html/body/pre/a[contains(.,'Content-Transfer-Encoding')]
    :FOR    ${i}    IN RANGE    999999
    \    ${i}=   Evaluate	${i} + 1
    \    ${xpath_count}=   Evaluate	${count} + ${i}
    \    ${email_xpath}=    Get text    xpath=//body/pre/a[${row}]
    \    Exit For Loop If    '${email_xpath}' == 'Content-Transfer-Encoding: quoted-printable-201..>'
    \    ${i}=   Evaluate	${i} + 1
    \    ${row}=   Evaluate	${row} + 1
    \    Log    ${i}
    \    Log    ${row}

    #${xpath_count}=   Evaluate	${count} + 1
    Click Element     xpath=//html/body/pre/a[${xpath_count}]
    ${verification_url}=   Get Text    xpath=//html/body/center/table[@id='3D"bodyTable"']/tbody/tr/td[@id='3D"bodyCell"']/table[@id='3D"templateContainer"']/tbody/tr[2]/td/table[@id='3D"templateBody"']/tbody/tr/td[@class='3D"bodyCon=']/p[3]/a
    ${token} =	Get Substring	${verification_url}	  -8
    ${registration_url} =	Set Variable   ${token_url}${token}
    Go To   ${registration_url}

Create Virtual Account 
    [Arguments]  ${country_id}

    ${random_int}=        Evaluate	random.randint(0, 999)   modules=random,sys
    set global variable   ${email_id}          test_qa_${country_id}_${random_int}@binary.com
    Input Text    email   ${email_id}
    Click Element   id=btn_verify_email
    Sleep  5
    Wait Until Page Contains   Thank you for signing up 
    Click Element  xpath=//*[@id="close_ico_banner"]
    Retrieve Token
    Input Text    client_password   ${user_password} 
    Input Text    repeat_password   ${user_password}
    Wait Until Element Contains   id=residence   id
    Select From List	id=residence   ${country_id}
    Click Element	xpath=//*[@id="virtual-form"]/div/button
    wait until page contains    Open a Real Account   60
    page should contain    You're using a Virtual Account

Verify CR Real Money Account Opening Fields
    Scroll Page To Middle
    #leave all fields as blank for fields checking
    Click Element	xpath=//*[@id="frm_real"]/div/button
    Xpath should match X Times     //div[@class="error-msg"]        10
    element text should be         //div[@class="error-msg"]        This field is required.
    element text should be         //*[@id="frm_real"]/fieldset[2]/div[6]/div[2]/div       You should enter 6-35 characters.
    element text should be         //*[@id="frm_real"]/fieldset[4]/div[2]/div        Please confirm that you are not a politically exposed person.
    element text should be         //*[@id="frm_real"]/div/div/div/div        Please accept the terms and conditions.

Set Birth Date
    [Arguments]  ${dob_year}   ${dob_month}
    click element  id=date_of_birth
    Select From List   xpath=//*[@id="ui-datepicker-div"]/div/div/select[2]   ${dob_year}
    Select From List   xpath=//*[@id="ui-datepicker-div"]/div/div/select[1]  ${dob_month}
    #hardcoded to 8
    click element      xpath=//*[@id="ui-datepicker-div"]/table/tbody/tr[2]/td[6]/a

Set Currency
    [Arguments]  ${currency}
    Execute Javascript	window.scrollTo(0,document.body.scrollHeight/3);
    Sleep   3
    click element  xpath=//*[@id="${currency}"]
    scroll page to middle
    Sleep   3
    click element  xpath=//*[@id="frm_set_currency"]/button

Input Fields for CR Real Money Account Opening
    [Arguments]  ${first_name}
    Input Text	first_name    ${first_name} 
    Input Text	last_name     ${last_name}
    ${elem}=   Get Value   last_name
    #get birth date equal to current date minus 30 days to verify age so that we get error too young to open account
    ${birth_date}=   Get Current Date	local    -30 days   %d %b, %Y
    Execute JavaScript  document.getElementById('date_of_birth').value='${birth_date}'
    Select From List	id=account_opening_reason	${account_opening_reason}
    Input Text	address_line_1	${address_line_1}
    Input Text  address_city	${address_city}
    Input Text	phone	${phone}
    Input Text 	secret_answer 	${secret_answer}
    Scroll Page To Middle
    Select Checkbox	not_pep
    Select Checkbox	tnc

Logout and Login
    Click Element	css=div.account-id
    Click Element   id=btn_logout
    Sleep    5
    wait until page contains    Log in  30
    Click Link	btn_login
    Set Selenium Speed    ${DELAY}
    Login Page Should Be Open
    Valid Login With Email ID    ${email_id}   ${user_password}
    Wait Until Page Contains	Portfolio   30


    
