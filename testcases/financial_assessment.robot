
*** Settings ***
Documentation     A test suite with test for financial assessment page
...
...               This test has a workflow that is created using keywords in
...               the imported resource file.
Resource          ../common/resource.robot
Resource          ../common/navigation.robot
Library           String
Library           Collections


*** Variables ***
${error_msg}                This field is required.
${empty_option}             option[1]
${original_option}          option[2]
${update_option}            option[3]
${with_error}               error-msg
${without_error}            error-msg invisible
@{option_id_list}=          forex_trading_experience
...                         forex_trading_frequency
...                         indices_trading_experience
...                         indices_trading_frequency
...                         commodities_trading_experience
...                         commodities_trading_frequency
...                         stocks_trading_experience
...                         stocks_trading_frequency
...                         other_derivatives_trading_experience
...                         other_derivatives_trading_frequency
...                         other_instruments_trading_experience
...                         other_instruments_trading_frequency
...                         income_source
...                         employment_status
...                         employment_industry
...                         occupation
...                         source_of_wealth
...                         education_level
...                         net_income
...                         estimated_worth
...                         account_turnover


*** Keywords ***

Verify the page is loaded successfully
    sleep  5
    wait Until Page Contains	Financial Information	15


Verify each field
    [Arguments]  ${error}
    sleep  5
    : FOR  ${i}  IN  @{option_id_list}
    \   Page should contain element   xpath=//*[@class="${error}"] //preceding::select[@id="${i}"]
    \   Run keyword if  "${error}"=="${with_error}"
        ...   element text should be         //div[@class="error-msg"]        This field is required.
        ...   ELSE
        ...   element text should be         //div[@class="error-msg invisible"]    ${EMPTY}


Verify successful message appears
    Wait until page contains    Your changes have been updated successfully.    10


Set financial information
    [Arguments]  ${options}
    : FOR  ${i}  IN  @{option_id_list}
    \   Click element   xpath=//*[@id="${i}"]/${options}
    Click element   id=btn_submit


Verify the updated information
    [Arguments]  ${options}
    : FOR  ${option_id}  IN  @{option_id_list}
    \   ${expected_option_value}=    Get text    xpath=//*[@id="${option_id}"]/${options}[@value]
    \   ${selected_option_value}=   Get selected list value    //*[@id="${option_id}"]
    \   Should Be Equal As Strings    ${selected_option_value}  ${expected_option_value}


Verify nothing to change message appear
    Wait until page contains    You did not change anything.    10


*** Test Cases ***

Check each field can be updated
    open xvfb browser then login
    Navigate to financial assessment page
    Verify the page is loaded successfully
    Set financial information   ${original_option}
    Sleep   3
    Set financial information   ${update_option}
    Verify successful message appears
    Capture page screenshot         screenshots/financialAssessment_updated_field.png
    Reload page
    Verify each field   ${without_error}
    Verify the updated information  ${update_option}



Check each empty field with error
    reload page
    Verify the page is loaded successfully
    Set financial information   ${original_option}
    Sleep   3
    Set financial information   ${empty_option}
    Verify each field   ${with_error}
    Capture page screenshot         screenshots/financialAssessment_field_with_error.png


Check nothing to update
    reload page
    Verify the page is loaded successfully
    Set financial information   ${original_option}
    Sleep   3
    Set financial information   ${original_option}
    Verify nothing to change message appear
    Capture page screenshot         screenshots/financialAssessment_no_update.png
    [Teardown]    Close Browser
