
*** Settings ***
Documentation     A test suite with a single test for checking API Token page
...
...               This test has a workflow that is created using keywords in
...               the imported resource file.
Resource          ../common/resource.robot
Resource          ../common/navigation.robot


*** Variables ***



*** Keywords ***
Navigate to API Token Page

    navigate to setting&security
    wait until element is visible       xpath=//*[@id="settings_container"]/div/div[6]/div[1]/a
    click element                       xpath=//*[@id="settings_container"]/div/div[6]/div[1]/a



Verify the page is loaded successfuly

    #wait until element is visible           xpath=//*[@id="api_token"]/h1
    wait until element is visible           xpath=//*[@id="api_token"]/ul
    wait until element is visible           xpath=//*[@id="token_form"]/form
    sleep  2
    ${DELETE_EXISTING}                       run keyword and return status      page should contain    ${TOKEN_NAME_INPUT}
    run keyword if                          ${DELETE_EXISTING}    delete token
    page should contain                     Choose token Name
    mouse over                              xpath=//*[@id="token_form"]/form/fieldset/div[2]/div[2]/label[1]



Verify required fields
    click button              xpath=//*[@id="btn_submit"]
    ${SCOPE_SELECTED}         run keyword and return status  checkbox should be selected         xpath=//*[@id="chk_scopes_read"]
    run keyword if            ${SCOPE_SELECTED}   click read scope
    #element text should be    xpath=//*[@id="token_form"]/form/fieldset/div[2]/div[2]/div                ${SCOPE_REQUIRED_MSG}
    element text should be    xpath=//*[@id="token_form"]/form/fieldset/div[2]/div[2]/p                ${SCOPE_REQUIRED_MSG}
    #element text should be    xpath=//*[@id="token_form"]/form/fieldset/div[1]/div[2]/div                ${REQUIRED_FIELD_MSG}
    element text should be    xpath=//*[@id="token_form"]/form/fieldset/div[1]/div[2]/p                ${REQUIRED_FIELD_MSG}

Click Read Scope
    sleep       2
    unselect checkbox               xpath=//*[@id="chk_scopes_read"]

Click Scopes
    wait until element is visible     xpath=//*[@id="chk_scopes_read"]
    select checkbox                   xpath=//*[@id="chk_scopes_read"]
    wait until element is visible     xpath=//*[@id="chk_scopes_trade"]
    select checkbox                   xpath=//*[@id="chk_scopes_trade"]
    wait until element is visible     xpath=//*[@id="chk_scopes_payments"]
    select checkbox                   xpath=//*[@id="chk_scopes_payments"]
    wait until element is visible     xpath=//*[@id="chk_scopes_admin"]
    select checkbox                   xpath=//*[@id="chk_scopes_admin"]


Verify invalid input

    input text                      txt_name                                                     a
    element text should be          xpath=//*[@id="token_form"]/form/fieldset/div[1]/div[2]/p       You should enter 2-32 characters.
    input text                      txt_name                ${INV_CHAR_INPUT}
    element text should be          xpath=//*[@id="token_form"]/form/fieldset/div[1]/div[2]/p                 ${INV_CHAR_INPUT_MSG}

Add new token
    reload page
    sleep  5
    wait until element is visible     xpath=//*[@id="chk_scopes_read"]
    input text                        txt_name                ${TOKEN_NAME_INPUT}
    click scopes
    click button                      xpath=//*[@id="btn_submit"]
    wait until element is visible     xpath=//*[@id="msg_form"]/ul/li
    wait until element is visible     xpath=//*[@id="tokens_table"]
    wait until element is visible     css=tr.new

Verify duplicate name
    reload page
    sleep  5
    wait until element is visible     xpath=//*[@id="chk_scopes_read"]
    input text                        txt_name                ${TOKEN_NAME_INPUT}
    click scopes
    click button                      xpath=//*[@id="btn_submit"]
    wait until element is visible     xpath=//*[@id="tokens_table"]
    wait until element is visible     xpath=//*[@id="msg_form"]
    element text should be            xpath=//*[@id="msg_form"]     ${NAME_TAKEN_MSG}
Verify empty list

    element should not be visible  xpath=//*[@id="tokens_table"]

Delete token
    click button                      xpath=.//*[td[contains(.,'${TOKEN_NAME_INPUT}')]]/td[5]/button
    confirm action

*** Test Cases ***
Check API Token Page
    open xvfb browser then login
    Navigate to API Token Page
    verify the page is loaded successfuly
    verify required fields
    verify invalid input
    Add new token
    verify duplicate name
    delete token
    [Teardown]    Close Browser
