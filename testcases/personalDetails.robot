
*** Settings ***
Documentation     A test suite with a single test for personal details page
...
...               This test has a workflow that is created using keywords in
...               the imported resource file.
Resource          ../common/resource.robot
Resource          ../common/navigation.robot
Library            String


*** Variables ***
${INV_CHAR_ADRRESS_MSG}               Only letters, numbers, space, and these special characters are allowed: - . ' # ; : ( ) , @ /
${INV_CHAR_TAX_ZIP_NO_MSG}            Only letters, numbers, space, and hyphen are allowed.
${INV_CHAR_CITY_MSG}                  Only letters, space, hyphen, period, and apostrophe are allowed.
${INV_CHAR_PHONE_MSG}                 Only numbers and spaces are allowed.
${MIN_INPUT_NO}                       1234
${MIN_PHONE_NO_MSG}                   You should enter 6-35 characters.

*** Keywords ***
Navigate to personal details page

    Navigate to profile
    wait until element is visible   xpath=//*[@id="settings_container"]/div/div[1]/div[1]/a
    click element                   xpath=//*[@id="settings_container"]/div/div[1]/div[1]/a


Verify the page is loaded successfuly

    sleep  5
    wait until element is visible           xpath=//*[@id="frmPersonalDetails"]/fieldset[1]
    wait until element is visible           xpath=//*[@id="frmPersonalDetails"]/fieldset[2]
    wait until element is visible           xpath=//*[@id="frmPersonalDetails"]/fieldset[3]

Verify required fields

    clear element text        xpath=//*[@id="address_line_1"]
    clear element text        address_city
    clear element text        phone
    wait until element is enabled  btn_update
    click button              btn_update
    wait until element is visible  xpath=//*[@id="frmPersonalDetails"]/fieldset[3]/div[1]/div[2]/div
    element text should be    xpath=//*[@id="frmPersonalDetails"]/fieldset[3]/div[1]/div[2]/div                  ${REQUIRED_FIELD_MSG}
    element text should be    xpath=//*[@id="frmPersonalDetails"]/fieldset[3]/div[3]/div[2]/div                  ${REQUIRED_FIELD_MSG}
    element text should be    xpath=//*[@id="frmPersonalDetails"]/fieldset[3]/div[6]/div[2]/div                  ${REQUIRED_FIELD_MSG}

Remove tax residence

    clear element text               xpath=.//*[@id='frmPersonalDetails']/fieldset[2]/div[1]/div[2]/span/span[1]/span/ul/li/input
Verify invalid input
    ${tax_residence}             run keyword and return status  should not be empty     tax_residence
    run keyword if                ${tax_residence}   Remove tax residence
    select from list                tax_residence   Angola      Denmark
    clear element text              tax_identification_number
    input text                      tax_identification_number                                                    ${INV_CHAR_INPUT}
    element text should be          xpath=//*[@id="frmPersonalDetails"]/fieldset[2]/div[2]/div[2]/div            ${INV_CHAR_TAX_ZIP_NO_MSG}
    input text                      address_line_1                                                               ${INV_CHAR_INPUT}
    element text should be          xpath=//*[@id="frmPersonalDetails"]/fieldset[3]/div[1]/div[2]/div            ${INV_CHAR_ADRRESS_MSG}
    clear element text              address_line_2
    input text                      address_line_2                                                               ${INV_CHAR_INPUT}
    element text should be          xpath=//*[@id="frmPersonalDetails"]/fieldset[3]/div[2]/div[2]/div            ${INV_CHAR_ADRRESS_MSG}
    clear element text              address_city
    input text                      address_city                                                                 ${INV_CHAR_INPUT}
    element text should be          xpath=//*[@id="frmPersonalDetails"]/fieldset[3]/div[3]/div[2]/div            ${INV_CHAR_CITY_MSG}
    clear element text              address_postcode
    input text                      address_postcode                                                             ${INV_CHAR_INPUT}
    element text should be          xpath=//*[@id="frmPersonalDetails"]/fieldset[3]/div[5]/div[2]/div            ${INV_CHAR_TAX_ZIP_NO_MSG}
    clear element text              phone
    input text                      phone                                                                         ${INV_CHAR_INPUT}
    element text should be          xpath=//*[@id="frmPersonalDetails"]/fieldset[3]/div[6]/div[2]/div             ${INV_CHAR_PHONE_MSG}
    clear element text              phone
    input text                      phone                                                                         ${MIN_INPUT_NO}
    element text should be          xpath=//*[@id="frmPersonalDetails"]/fieldset[3]/div[6]/div[2]/div             ${MIN_PHONE_NO_MSG}

Update personal details

    clear element text          tax_identification_number
    clear element text          address_line_1
    clear element text          address_line_2
    clear element text          address_city
    clear element text          address_postcode
    clear element text          phone
    ${RANDOM_NO}                generate random string  4  [NUMBERS]
    input text                  tax_identification_number        TX${RANDOM_NO}
    input text                  address_line_1                   (Daehan-minguk) Seoul-teukbyeolsi,
    input text                  address_line_2                   Jongno-gu, Sajik-ro-3-gil 23${RANDOM_NO}
    input text                  address_city                     SEOL
    input text                  address_postcode                 ${RANDOM_NO}
    ${PHONE_NO}                 Generate Random String  8  [NUMBERS]
    input text                  phone                            +${PHONE_NO}
    click button                btn_update
    wait until element is visible  xpath=//*[@id="formMessage"]/ul/li
    element text should be          xpath=//*[@id="formMessage"]/ul/li              Your settings have been updated successfully.


*** Test Cases ***
Check Personal Details
    open xvfb browser then login
    Navigate to personal details page
    verify the page is loaded successfuly
    verify required fields
    verify invalid input
    update personal details
    capture page screenshot         screenshots/changepassword.png
    [Teardown]    Close Browser
