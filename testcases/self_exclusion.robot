
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

    click button    btn_submit

Verify error message
     wait until page contains                ${SELF_EXCLUSION_INTRO}         10
    : FOR  ${i}  IN  @{FIELD_ID}
    \  ${original_value}             get value                xpath=//*[@id="${i}"]
  # \  ${original_value} =            replace string using regexp     ${original_value}        (\\d{3}$)    ,\\1
    \  ${Current_value}             get value             xpath=//*[@id="${i}"]
    \  ${Current_value}        evaluate  ${Current_value} +1
    \   Run keyword if       "${original_value}"!= "${empty}"
        ...    input text            xpath=//*[@id="${i}"]       ${Current_value}
    \   ${CONVER_NO}             get text         xpath=//*[@id="${i}"]//following-sibling::div[2]
    \   ${final_msg}            remove string  ${CONVER_NO}     ,
    #\   element text should be       xpath=//*[@id="frm_self_exclusion"]/fieldset/div[*]/div[2]/div[2]   Should be between 0 and ${original_value}
    \   should be equal       ${final_msg}      Should be between 0 and ${original_value}


*** Test Cases ***
Check Self Exclusion Page
    open login page in xvfb browser
    login using crypto account
    Navigate to Self Exclusion page
    verify the page is loaded successfuly
    verify error message
    reload page
    sleep   5
    update self-exlcusion
    capture page screenshot
    [Teardown]    Close Browser
