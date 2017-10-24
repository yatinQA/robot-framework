*** Settings ***
Documentation     A test suite with a single test for creating CR virtual account.
...
...               This test has a workflow that is created using keywords in
...               the imported resource file.
Resource          ../common/resource.robot
Resource	      ../common/create_account_resource.robot

*** Variables ***
${country_id}         id


*** Keywords ***
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

*** Test Cases ***
Create CR Virtual Account
    Prepare Endpoint Environment
    Create Virtual Account  ${country_id}
    capture page screenshot   screenshots/create_VRTC_acc.png
    Logout and Login
    [Teardown]    Close Browser

    
