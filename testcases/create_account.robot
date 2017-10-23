*** Settings ***
Documentation     A test suite with a single test for creating CR account.
...
...               This test has a workflow that is created using keywords in
...               the imported resource file.
Resource          ../common/resource.robot
Library 	      OperatingSystem
#Suite Teardown   Close All Connections

*** Variables ***
${ENDPOINT ADDRESS}   www.binaryqa10.com
${ENDPOINT APP ID}    1003
${HOST}               localhost
#${sshqasg}	          ssh -A munsei@sshqasg.regentmarkets.com -p 22884 "ssh -o BatchMode=yes qa37 \"${token_grep}\""
#${sshqasg}           ssh -t munsei@sshqasg.regentmarkets.com -A -p 22884 ssh -A -p 22 -t munsei@qa37 \"ls -la\" 
#${sshqa}	          ssh qa37  "ls"
${email_url}          https://${ENDPOINT ADDRESS}/emails/
${email_subject}      Content-Transfer-Encoding
${token_url}          https://staging.binary.com/en/redirect.html?action=signup=EN&code=
#${token_grep}        grep -oP \"(?<=\\>)([A-z0-9]{8})(?=\\=)\" /tmp/default.mailbox |tail -1
#${token_grep}        grep -o '[^ ]*code[^ ]*' default.mailbox | cut -c61-68 | tail -1
${user_password}      Binary@1
${country}	          Indonesia


*** Keywords ***
Send  [Arguments]  ${input}
	Run Keyword If      '${input}'=='${empty}'  Log  <Enter>   WARN
	Run Keyword Unless  '${input}'=='${empty}'  Log  ${input}  WARN
	Run  ${input}

#Open Connection And Log In
   #Run Process   ssh-add /Users/lokemunsei/.ssh/id_rsa  shell=True  timeout=10s
   #${verification_code} =	Get Value From User	Please enter Verification Code

   #${rc}       ${stdout} =     Run and Return RC and Output   ${token_grep}
   #${registration_url} =	Set Variable   ${token_url}${stdout}	
   #Go To   ${registration_url}
   #Run   ssh-add /Users/lokemunsei/.ssh/id_rsa  
   #${rc}	${stdout} =	Run and Return RC and Output   ssh-add /Users/lokemunsei/.ssh/id_rsa
   #${rc}        ${stdout} =     Run and Return RC and Output   ${sshqasg}
   #Run   echo ${rc}, ${stdout}
   #${rc}        ${stdout} =     Run and Return RC and Output   ssh qa37   
   #${rc}        ${stdout} =     Run and Return RC and Output   ls
   #${rc}        ${stdout} =     Run and Return RC and Output   ${token_grep}   

   #Open Connection    ${HOST}
   #Write    ssh-add /Users/lokemunsei/.ssh/id_rsa
   #Read Until Prompt
   #Write    ${pass_phrase}
   #${output}=	Read
   #Write    ssh -A munsei@sshqasg.regentmarkets.com -p 22884
   #${output}=	Read
   #Login    ${USERNAME}    ${PASSWORD}

Retrieve Token
    Go To   ${email_url}
    ${count}=   Get Matching Xpath Count    //html/body/pre/a[contains(.,'Content-Transfer-Encoding')]
    ${xpath_count}=   Evaluate	${count} + 1
    Click Element     xpath=//html/body/pre/a[${xpath_count}]
    ${verification_url}=   Get Text    xpath=//html/body/center/table[@id='3D"bodyTable"']/tbody/tr/td[@id='3D"bodyCell"']/table[@id='3D"templateContainer"']/tbody/tr[2]/td/table[@id='3D"templateBody"']/tbody/tr/td[@class='3D"bodyCon=']/p[3]/a
    ${token} =	Get Substring	${verification_url}	  -8
    ${registration_url} =	Set Variable   ${token_url}${token}
    Go To   ${registration_url}
    #Open Connection And Log In

*** Test Cases ***
Prepare Endpoint Environment
    Set Endpoint   ${ENDPOINT ADDRESS}   ${ENDPOINT APP ID} 
    Click Element  xpath=//a[@id='logo']/div/div[2]/div
    Wait Until Element Is Visible   btn_verify_email
    Sleep  5

Create Virtual Account
    ${random_int}=        Evaluate	random.randint(0, 999)   modules=random,sys
    set global variable   ${email_id}           test_qa_${random_int}@binary.com
    Input Text    email   ${email_id}
    Click Element   id=btn_verify_email
    Sleep  5
    Wait Until Page Contains   Thank you for signing up 
    Retrieve Token
    Input Text    client_password   ${user_password} 
    Input Text    repeat_password   ${user_password}
    Wait Until Element Contains   id=residence   id
    Select From List	id=residence   id
    Click Element	xpath=//*[@id="virtual-form"]/div/button
    wait until page contains    Open a Real Account   60
    page should contain    You're using a Virtual Account

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
    #capture page screenshot   screenshots/create_virtual_acc.png
    [Teardown]    Close Browser

    
