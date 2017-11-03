
*** Settings ***
Documentation     A test suite with a single test for checking JP Trading Times page
...
...               This test has a workflow that is created using keywords in
...               the imported resource file.
Resource          ../common/resource.robot
Resource          ../common/navigation.robot
Library            String
Library            Collections


*** Variables ***

*** Keywords ***
Navigate to trading times

    Navigate to resources page
    wait until element is visible   xpath= //*[@id="content"]/div[3]/div/div[2]/div[1]/a
    click element                   xpath= //*[@id="content"]/div[3]/div/div[2]/div[1]/a


Verify the page is loaded successfuly

    sleep  5
    wait until element is visible           xpath=//*[@id="market_1"]/div/div
    page should contain                    当社サイトの時間表示は全て、GMT（グリニッジ標準時）に基づきます。


verify the markets is correct
    wait until element is visible               xpath=//*[@id="外国為替-0"]/tbody/tr[*]/td[1]
    ${count}=    Get Matching Xpath Count   xpath=//*[@id="外国為替-0"]/tbody/tr[*]/td[1]
    ${ACTUAL_MARKKETS}=    Create List
    :FOR    ${i}    IN RANGE    1    ${count}+1
    \   ${ACTUAL_MARKKET}=    Get Text        xpath=//*[@id="外国為替-0"]/tbody/tr[${i}]/td[1]
    \    Append To List   ${ACTUAL_MARKKETS}    ${ACTUAL_MARKKET}
    ${EXPECTED_MARKET}      create list         AUD/JPY              AUD/USD         EUR/GBP    EUR/JPY     EUR/USD     GBP/JPY     GBP/USD     USD/CAD     USD/JPY
    log      ${ACTUAL_MARKKETS}
    lists should be equal  ${ACTUAL_MARKKETS}    ${EXPECTED_MARKET}


*** Test Cases ***
Check JP trading Times Page
    open xvfb browser then login using jp account
    Navigate to trading times
    verify the page is loaded successfuly
    verify the markets is correct
    capture page screenshot         screenshots/JPTradingTimes.png
    [Teardown]    Close Browser
