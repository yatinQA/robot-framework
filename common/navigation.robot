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


Navigate to JP setting&security
    Sleep  5
    Click Element	css=div.account-id
    Click Element	css=li.topMenuSecurity
    Wait Until Page Contains	セキュリティ情報   5


Navigate to cashier page
    click element                       xpath=//*[@id="topMenuCashier"]/a

Navigate to resources page
    click element                xpath=//*[@id="topMenuResources"]/a

Navigate to Statement Page
    click element                  xpath=//*[@id="topMenuStatement"]/a

Navigate to portfolio Page
    click element               xpath=//*[@id="topMenuPortfolio"]/a

Navigate to Profit Table Page

    click element           xpath=//*[@id="topMenuProfitTable"]/a


Navigate to profile
    sleep  3
    click element  css=div.account-id
    click element  xpath=//*[@id="all-accounts"]/li/ul/a[1]/li
    wait until page contains    Profile     5

Navigate to financial assessment page
    Sleep   5
    navigate to profile
    wait until element is visible   xpath=//*[@id="settings_container"]/div/div[1]/div[1]/a
    click element                   xpath=//*[@id="settings_container"]/div/div[2]/div[2]/h4/a
