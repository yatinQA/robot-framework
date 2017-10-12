*** Settings ***
Documentation     A test suite with a single test for to test mailer link in footer is not broken.
...
...               This test has a workflow that is created using keywords in
...               the imported resource file.
Resource          ../common/resource.robot

*** Keywords ***
Check Open Tab
    [Arguments]	  ${mailer_link}
    ${Current_window}        List Windows
    Click Element            xpath=${mailer_link}
    ${New_Windows_list}      List Windows
    Should Not Be Equal      ${Current_window}    ${New_Windows_list}
    Sleep   5

Verify YouTube Link
    ${youtube_path} =	Set Variable   //*[@id="social-networks"]/div[2]/a[1]/img
    Wait Until Element Is Visible   xpath=${youtube_path}
    Check Open Tab  ${youtube_path}
    Select Window   url=https://www.youtube.com/user/BinaryTradingVideos
    Page Should Contain  What Is Binary Options Trading?
    capture page screenshot    screenshots/youtube.png
    select window  url=${HOME URL}

Verify GooglePlus Link
    ${googleplus_path} =	Set Variable   //*[@id="social-networks"]/div[2]/a[2]/img
    Wait Until Element Is Visible   xpath=${googleplus_path}
    Check Open Tab  ${googleplus_path}
    Select Window   url=https://plus.google.com/+Binarydotcom
    #select window    url=https://plus.google.com/106251151552682209951
    Page Should Contain  Join Google+
    capture page screenshot    screenshots/googleplus.png
    select window  url=${HOME URL}

Verify Facebook Link
    ${facebook_path} =	Set Variable   //*[@id="social-networks"]/div[2]/a[3]/img
    Wait Until Element Is Visible   xpath=${facebook_path}
    Check Open Tab  ${facebook_path}
    Select Window   url=https://www.facebook.com/binarydotcom
    Page Should Contain  Binary.com
    capture page screenshot    screenshots/facebook.png
    select window  url=${HOME URL}

Verify Twitter Link
    ${twitter_path} =	Set Variable   //*[@id="social-networks"]/div[2]/a[4]/img
    Wait Until Element Is Visible   xpath=${twitter_path}
    Check Open Tab  ${twitter_path}
    Select Window   url=https://twitter.com/Binarydotcom
    Page Should Contain  Binary.com
    capture page screenshot    screenshots/twitter.png
    select window  url=${HOME URL}

Verify Telegram Link
    ${telegram_path} =	Set Variable   //*[@id="social-networks"]/div[2]/a[5]/img
    Wait Until Element Is Visible   xpath=${telegram_path}
    Check Open Tab  ${telegram_path}
    Select Window   url=https://t.me/binarydotcom
    Page Should Contain  Binary.com Group
    capture page screenshot    screenshots/telegram.png
    select window  url=${HOME URL}

Verify Reddit Link
    ${reddit_path} =	Set Variable   //*[@id="social-networks"]/div[2]/a[6]/img
    Wait Until Element Is Visible   xpath=${reddit_path}
    Check Open Tab  ${reddit_path}
    Select Window   url=https://www.reddit.com/r/binarydotcom/
    Page Should Contain  Binary.com
    capture page screenshot    screenshots/reddit.png
    select window  url=${HOME URL}

*** Test Cases ***
Check Mailer Link
    #Chrome Headless
    #Go To   ${HOME URL}
    Open Browser    ${HOME URL}    ${BROWSER}

    #scroll to bottom of the page
    Execute Javascript	window.scrollTo(0,document.body.scrollHeight);

    Verify YouTube Link
    Verify GooglePlus Link
    Verify Facebook Link
    Verify Twitter Link
    Verify Telegram Link
    Verify Reddit Link

    [Teardown]    Close Browser
