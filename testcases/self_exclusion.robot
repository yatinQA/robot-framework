
*** Settings ***
Documentation     A test suite with a single test for checking  Self Exclusion Page
...
...               This test has a workflow that is created using keywords in
...               the imported resource file.
Resource          ../common/resource.robot
Resource          ../common/navigation.robot
Library            String
Library            Collections


*** Variables ***
${SELF_EXCLUSION_INTRO}     Trading the financial markets can become addictive. Fill in the form below to limit your participation on the
...                         website or send a signed letter or fax to our customer support team.
...                         Once set, you can only tighten your limits. Limits will only be removed
...                         or loosened after 7 days with the exception of the self-exclusion date,
...                         which cannot be removed or altered once you have confirmed it. To remove or
...                        increase your limits, please contact customer support.

@{FIELD_ID}                max_balance
...                        max_turnover
...                        max_losses
...                        max_7day_turnover
...                        max_7day_losses
...                        max_30day_turnover
...                        max_open_bets




*** Keywords ***

Navigate to Self Exclusion page

    Navigate to setting&security
    wait until element is visible   xpath=//*[@id="settings_container"]/div/div[3]/div[1]/a/img
    reload page
    wait until element is visible   xpath=//*[@id="settings_container"]/div/div[3]/div[1]/a
    click element                   xpath=//*[@id="settings_container"]/div/div[3]/div[1]/a

Verify the page is loaded successfuly

    wait until page contains                ${SELF_EXCLUSION_INTRO}         10
    page should contain                     Self-Exclusion Facilities
    wait until element is visible           xpath=//*[@id="frm_self_exclusion"]      10

Verify the field is Empty

    : FOR  ${i}  IN  @{FIELD_ID}

    \  ${selected_option_value}        get value       xpath=//*[@id="${i}"]
    \  ${Current_value}             get value       xpath=//*[@id="${i}"]
    \  ${Current_value}        evaluate  ${Current_value} -1
    \   Run keyword if       "${selected_option_value}"== "${empty}"
        ...    input text       xpath=//*[@id="${i}"]       1000
        ...    ELSE
        ...    input text            xpath=//*[@id="${i}"]       ${Current_value}

    click button    btn_submit

Verify the page in JP is loaded successfuly

    sleep  5
    page should contain                     取引上限及び出金限度額の設定
    ${USER_ID}      get text                xpath=//*[@id="main-account"]/li/a/div[1]/div[2]
    element text should be                  xpath=//*[@id="trading-limits"]              ${USER_ID} - 取引上限について
    wait until element is visible           xpath=//*[@id="client-limits"]
    element should not be visible           xpath=//*[@id="withdrawal-title"]




*** Test Cases ***
Check Limit Page for CR Account
    open login page in xvfb browser
    login using crypto account
    Navigate to Self Exclusion page
    verify the page is loaded successfuly
    verify the field is empty
    capture page screenshot
    [Teardown]    Close Browser
