
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
${INV_CHAR_ZIP_NO_MSG}            Only letters, numbers, space, and hyphen are allowed.
${INV_CHAR_TAX_NO_MSG}            Should start with letter or number, and may contain hyphen and underscore.
${INV_CHAR_CITY_MSG}                  Only letters, space, hyphen, period, and apostrophe are allowed.
${INV_CHAR_PHONE_MSG}                 Only numbers and spaces are allowed.
${MIN_INPUT_NO}                       1234
${MIN_PHONE_NO_MSG}                   You should enter 6-35 characters.
${Tax_No}
${Selected_tax_residence}
${address_line1}
${address_line2}
${address_city}
${address_postcode}
${VAR_PHONE_NO}

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

    clear element text              tax_identification_number
    input text                      tax_identification_number                                                    ${INV_CHAR_INPUT}
    element text should be          xpath=//*[@id="frmPersonalDetails"]/fieldset[2]/div[2]/div[2]/div            ${INV_CHAR_TAX_NO_MSG}
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
    element text should be          xpath=//*[@id="frmPersonalDetails"]/fieldset[3]/div[5]/div[2]/div            ${INV_CHAR_ZIP_NO_MSG}
    clear element text              phone
    input text                      phone                                                                         ${INV_CHAR_INPUT}
    element text should be          xpath=//*[@id="frmPersonalDetails"]/fieldset[3]/div[6]/div[2]/div             ${INV_CHAR_PHONE_MSG}
    clear element text              phone
    input text                      phone                                                                         ${MIN_INPUT_NO}
    element text should be          xpath=//*[@id="frmPersonalDetails"]/fieldset[3]/div[6]/div[2]/div             ${MIN_PHONE_NO_MSG}

Update personal details
    ${tax_residence}            run keyword and return status  should not be empty     tax_residence
    run keyword if              ${tax_residence}
    ...     click element         xpath=//*[@id="frmPersonalDetails"]/fieldset[2]/div[1]/div[2]/span/span[1]/span/ul/li[*]/span
    select from list            tax_residence       Angola      Denmark
    clear element text          tax_identification_number
    clear element text          address_line_1
    clear element text          address_line_2
    clear element text          address_city
    clear element text          address_postcode
    clear element text          phone
    ${RANDOM_NO}                generate random string  4  [NUMBERS]
    input text                  tax_identification_number        TX${RANDOM_NO}
    ${Tax_No}                   get value                        tax_identification_number
    set global variable         ${Tax_No}
    input text                  address_line_1                   (Daehan-minguk) Seoul-teukbyeolsi,
    ${address_line1}             get value                        address_line_1
    set global variable         ${address_line1}
    input text                  address_line_2                   Jongno-gu, Sajik-ro-3-gil 23${RANDOM_NO}
    ${address_line2}             get value                        address_line_2
    set global variable         ${address_line2}
    input text                  address_city                     SEOL
    ${address_city}             get value                       address_city
    set global variable         ${address_city}
    input text                  address_postcode                     ${RANDOM_NO}
    ${address_postcode}         get value                         address_postcode
    set global variable         ${address_postcode}
    ${PHONE_NO}                 Generate Random String  8  [NUMBERS]
    input text                  phone                            +${PHONE_NO}
    ${VAR_PHONE_NO}            get value                          phone
    set global variable         ${VAR_PHONE_NO}

    click button                  xpath=//*[@id="btn_update"]
    wait until element is visible  xpath=//*[@id="formMessage"]/ul/li       10
    element text should be          xpath=//*[@id="formMessage"]/ul/li              Your settings have been updated successfully.

Check Personal Details After Update

    ${expected_tax_residence}         create list     Angola      Denmark
    reload page
    sleep       5
    ${Selected_tax_residence}                get selected list labels             tax_residence
    should be equal                            ${Selected_tax_residence}          ${expected_tax_residence}
    textfield value should be                  tax_identification_number            ${Tax_No}
    textfield value should be                 address_line_1                       ${address_line1}
    textfield value should be                 address_line_2                       ${address_line2}
    textfield value should be                 address_city                         ${address_city}
    textfield value should be                  address_postcode                     ${address_postcode}
    textfield value should be                 phone                                ${VAR_PHONE_NO}


*** Test Cases ***
Check Personal Details
    open xvfb browser then login
    Navigate to personal details page
    verify the page is loaded successfuly
    verify required fields
    verify invalid input
    update personal details
    check personal details after update
    capture page screenshot         screenshots/personalDetail.png
    [Teardown]    Close Browser
