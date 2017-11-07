
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
...                        max_30day_losses



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

Update self-exlcusion

    : FOR  ${i}  IN  @{FIELD_ID}

    \  ${original_value}            get value       xpath=//*[@id="${i}"]
    \  ${Current_value}             get value       xpath=//*[@id="${i}"]
    \  ${Current_value}        evaluate  ${Current_value} -1
    \   Run keyword if       "${original_value}"== "${empty}"
        ...    input text       xpath=//*[@id="${i}"]       1000
        ...    ELSE
        ...    input text            xpath=//*[@id="${i}"]       ${Current_value}

    ${original_Max_OpenValue}        get value       xpath=//*[@id="max_open_bets"]
    ${Update_MaxOpenBet}             get value       xpath=//*[@id="max_open_bets"]
    ${Update_MaxOpenBet}             evaluate  ${original_Max_OpenValue} -1
    Run keyword if                  "${original_Max_OpenValue}"== "${empty}"
     ...    input text       xpath=//*[@id="max_open_bets"]       60
     ...    ELSE
     ...    input text       xpath=//*[@id="max_open_bets"]      ${Update_MaxOpenBet}
    click button    btn_submit
    wait until page contains    Your changes have been updated.

Verify error message
     wait until page contains                ${SELF_EXCLUSION_INTRO}         10
    : FOR  ${i}  IN  @{FIELD_ID}
    \  ${original_value}             get value                xpath=//*[@id="${i}"]
    \  ${Current_value}             get value             xpath=//*[@id="${i}"]
    \  ${Current_value}        evaluate  ${Current_value} +1
    \   Run keyword if       "${original_value}"!= "${empty}"
        ...    input text            xpath=//*[@id="${i}"]       ${Current_value}
    \   ${CONVER_NO}             get text         xpath=//*[@id="${i}"]//following-sibling::div[2]
    \   ${final_msg}            remove string  ${CONVER_NO}     ,
    \   should be equal       ${final_msg}      Should be between 0 and ${original_value}
    \   reload page
    \   sleep       5
    \   wait until page contains       ${SELF_EXCLUSION_INTRO}         10
    \   run keyword if       "${original_value}"!= "${empty}"
        ...    input text            xpath=//*[@id="${i}"]      444.3344343
    \   element text should be           xpath=//*[@id="${i}"]//following-sibling::div[2]       Only 0, 2 decimal points are allowed.
    \   clear element text       xpath=//*[@id="${i}"]
    \   element text should be           xpath=//*[@id="${i}"]//following-sibling::div[2]       This field is required.
    input text                       xpath=//*[@id="max_open_bets"]    123.21
    element text should be           xpath=//*[@id="max_open_bets"]//following-sibling::div[2]               Should be a valid number
    input text                       xpath=//*[@id="session_duration_limit"]    123.21
    element text should be           xpath=//*[@id="session_duration_limit"]//following-sibling::div[2]    Should be a valid number

Check date validation

    #Select the date without selected date to triger validation error
    click element               timeout_until_time
    click element               xpath=//*[@id="ui-timepicker-div"]/table/tbody/tr/td[1]/table/tbody/tr[2]/td[4]/a
    click element               xpath=//*[@id="ui-timepicker-div"]/table/tbody/tr/td[2]/table/tbody/tr[2]/td[2]/a
    element should be visible   xpath=//*[@id="frm_self_exclusion"]/fieldset/div[10]/div[2]/div[1]/div[1]/div
    element text should be      xpath=//*[@id="frm_self_exclusion"]/fieldset/div[10]/div[2]/div[1]/div[1]/div     This field is required.
    click element               timeout_until_date
    click element                xpath=//*[@id="ui-datepicker-div"]/div/div/select[1]/option[1]
    click element               xpath=//*[@id="ui-datepicker-div"]/div/div/select[2]/option[1]
    click element               xpath=//*[@id="ui-datepicker-div"]/table/tbody/tr[2]/td[6]/a
    element should not be visible   xpath=//*[@id="frm_self_exclusion"]/fieldset/div[10]/div[2]/div[1]/div[1]/div
    click element               exclude_until
    click element                xpath=//*[@id="ui-datepicker-div"]/div/div/select[1]/option[1]
    click element               xpath=//*[@id="ui-datepicker-div"]/div/div/select[2]/option[1]
    click element               xpath=//*[@id="ui-datepicker-div"]/table/tbody/tr[2]/td[6]/a
*** Test Cases ***
Check Self Exclusion Page
    open login page in xvfb browser
    login using crypto account
    Navigate to Self Exclusion page
    verify the page is loaded successfuly
    verify error message
    check date validation
    reload page
    sleep   5
    update self-exlcusion
    capture page screenshot
    [Teardown]    Close Browser
