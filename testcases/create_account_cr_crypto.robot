*** Settings ***
Documentation     A test suite with a single test for creating CR - crypto accounts.
...
...               This test has a workflow that is created using keywords in
...               the imported resource file.
Resource          ../common/resource.robot
Resource	      ../common/create_account_resource.robot
Library 	      OperatingSystem


*** Variables ***
${country}	          Indonesia
${country_id}		  id
${currency_fiat}      USD
@{crypto_list}=       BCH
...                   BTC
...                   ETH
...                   LTC

*** Keywords ***
Create Crypto Accounts
    [Arguments]  ${crypto_currency}
    Click Element  css=div.account-id
    Click Element  xpath=//*[@id="user_accounts"]/li
    wait until page contains  Create New Account   30
    reload page
    wait until element is visible   xpath=//*[@id="new_account_opening"]/td[4]/button   60
    Run keyword if  "${crypto_currency}"!="LTC"
    ...   Select From List	id=new_account_currency   ${crypto_currency}
    sleep  5
    wait until element is visible   xpath=//*[@id="new_account_opening"]/td[4]/button   60
    Click Element  xpath=//*[@id="new_account_opening"]/td[4]/button
    wait until page contains  ${crypto_currency} Account   30
    capture page screenshot   screenshots/create_CR_${crypto_currency}_acc.png

*** Test Cases ***
Create CR Fiat Account
    Prepare Endpoint Environment
    Create Virtual Account  ${country_id}

    Wait Until Page Contains	Family name	30
    ${random_first_name}=	Generate Random String	5	[LETTERS]
    set global variable   ${first_name}           test-cr-${random_first_name}
    Sleep   5
    Input Fields for CR Real Money Account Opening		${first_name}
    #Update birthdate to be able to open account
    Scroll Page To Top
    Sleep  5
    Set Birth Date   1983  Jul
    Scroll Page To Middle
    Click Element	xpath=//*[@id="frm_real"]/div/button
    Sleep  5
    wait until element is visible   xpath=//*[@id="${currency_fiat}"]   60
    Page Should Contain    You have successfully created your account!
    Set Currency   ${currency_fiat}
    wait until page contains  ${currency_fiat} Account   30

Create CR Crypto Account
    : FOR  ${crypto}  IN  @{crypto_list}
    \    Create Crypto Accounts   ${crypto}

    [Teardown]    Close Browser
