
*** Settings ***
Documentation     A test suite with a single test for checking  Statement page
...
...               This test has a workflow that is created using keywords in
...               the imported resource file.
Resource          ../common/resource.robot
Resource          ../common/navigation.robot
Library            String
Library            Collections


*** Variables ***
${EMAIL_LOST}       ridhotest@mailinator.com
${token_url}        https://staging.binary.com/en/redirect.html?action=signup=EN&code=
${mailinator_URL}   https://www.mailinator.com/v2/inbox.jsp?zone=public&query=ridhotest#/#msgpane
*** Keywords ***

Check email validation

    click button    btn_submit
    wait until element is visible   xpath=//*[@id="frm_lost_password"]/fieldset/div[1]/div[2]/p     2
    input text      email       ${INV_INPUT}
    element should be visible   xpath=//*[@id="frm_lost_password"]/fieldset/div[1]/div[2]/p
    element text should be   xpath=//*[@id="frm_lost_password"]/fieldset/div[1]/div[2]/p      Invalid email address
    input text      email       ridhotest@mailinator.com
    click button    btn_submit
    wait until element is visible   xpath=//*[@id="frm_lost_password"]/div      10
    page should contain   Please check your email for the password reset link.


Get verification Link

    go to  ${mailinator_URL}
    wait until element is visible   xpath=(//DIV[@class='all_message-min_text all_message-min_text-3'][text()='Binary.com New Password Request'])[1]
                                    ...  5
    click element  xpath=(//DIV[@class='all_message-min_text all_message-min_text-3'][text()='Binary.com New Password Request'])[1]
    sleep       5
    sele
    ${TEST}     get text            xpath=//*[@id="templateBody"]/tbody/tr/td/p[2]



*** Test Cases ***
Check Statement Page
    open browser and then go to lost password page
    check email validation
    get verification link
    capture page screenshot
    [Teardown]    Close Browser
