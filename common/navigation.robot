*** Settings ***
Documentation     A Navigaton file with reusable keywords and variables for navigation.
...

Library		     String
Library           Selenium2Library 


*** Keywords ***

Navigate to setting&security
    Sleep  5
    Click Element	css=div.account-id
    Click Element	css=li.topMenuSecurity
    Wait Until Page Contains	Security   5

Navigate to cashier page

    click element                       xpath=//*[@id="topMenuCashier"]/a

Navigate to resources page
    click element                xpath=//*[@id="topMenuResources"]/a


Navigate to profile
    sleep  3
    click element  css=div.account-id
    click element  xpath=//*[@id="all-accounts"]/li/ul/a[1]/li
    wait until page contains    Profile     5
