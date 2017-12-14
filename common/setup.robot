*** Settings ***
Library           Selenium2Library
Library           OperatingSystem


*** Variables ***

${SiteUrl}        https://staging.binary.com/en/home.html
${Delay}          5s


*** Keywords ***
Open Binary Site
    ${BSUserNew}       get environment variable  BROWSERSTACK_USER
    ${AccessKeyNew}    get environment variable  BROWSERSTACK_ACCESS_KEY
    [Arguments]   ${BROWSER}  ${BROWSER_VERSION}  ${OS}  ${OS_VERSION}
    Open Browser   url=${SiteUrl}   browser=${BROWSER}   remote_url=http://${BSUserNew}:${AccessKeyNew}@hub-cloud.browserstack.com:80/wd/hub  desired_capabilities=browser:${BROWSER},browser_version:${BROWSER_VERSION},os:${OS},os_version:${OS_VERSION}

Open Binary Site In a Device
    ${BSUserNew}       get environment variable  BROWSERSTACK_USER
    ${AccessKeyNew}    get environment variable  BROWSERSTACK_ACCESS_KEY
    [Arguments]   ${DEVICE}  ${REALDEVICE}  ${OS_VERSION}
    Open Browser   url=${SiteUrl}   device=${DEVICE}   remote_url=http://${BSUserNew}:${AccessKeyNew}@hub-cloud.browserstack.com:80/wd/hub  desired_capabilities=browser:${DEVICE},realMobile:${REALDEVICE},os_version:${OS_VERSION}

Maximize Browser
    Maximize Browser Window
