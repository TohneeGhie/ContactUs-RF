*** Settings ***
Library  SeleniumLibrary

*** Variables ***
${browser}                                                  Chrome
${url}                                                      https://www.adrenalinmedia.com.au/
${firstname_alphabet}                                       Jennifer
${lastname_alphabet}                                        Blue
${phonenumber_alphabet}                                     abc
${phonenumber_specialcharacters}                            !@#$%^&*()_+-=`~[]\{}|;':",./<>?
${correct_phonenumber_count7}                               1234567
${correct_phonenumber_count20}                              12345678917894561230
${incorrect_phonenumber_count5}                             12345
${incorrect_phonenumber_count21}                            123456789178945612301

*** Test Cases ***
AdrenalinContact Page
    Open Browser                        ${url}  ${browser}
    Maximize Browser Window
    Set Selenium Implicit Wait          30
    Click Element                       xpath://span[normalize-space()='Contact']
    Scroll Element Into View            xpath://h3[normalize-space()='Project Enquiry']
    Set Selenium Implicit Wait          30
    Wait Until Page Contains Element    xpath://h3[normalize-space()='Project Enquiry']
    Capture Page Screenshot

PhoneNumber Field Validation
    Set Selenium Implicit Wait          1
    Scroll Element Into View            name:firstname
    Input Text                          name:firstname    ${firstname_alphabet}
    Page Should Not Contain Element     xpath://div[@class='hs_firstname hs-firstname hs-fieldtype-text field hs-form-field']//label[@class='hs-error-msg hs-main-font-element'][normalize-space()='Please complete this required field.']
    Set Selenium Implicit Wait          1
    Scroll Element Into View            name:lastname
    Input Text                          name:lastname    ${lastname_alphabet}
    Page Should Not Contain Element     xpath://div[@class='hs_firstname hs-firstname hs-fieldtype-text field hs-form-field']//label[@class='hs-error-msg hs-main-font-element'][normalize-space()='Please complete this required field.']
    Set Selenium Implicit Wait          3
    Scroll Element Into View            xpath://span[text()='Email']/../..
    Scroll Element Into View            name:phone
    Input Text                          name:phone    ${phonenumber_alphabet}
    Page Should Contain Element         xpath://label[contains(text(),'A valid phone number may only contain numbers, +()')]
    Set Selenium Implicit Wait          3
    Capture Page Screenshot
    Input Text                          name:phone    ${EMPTY}
    Input Text                          name:phone    ${phonenumber_specialcharacters}
    Page Should Contain Element         xpath://label[contains(text(),'A valid phone number may only contain numbers, +()')]
    Set Selenium Implicit Wait          3
    Capture Page Screenshot
    Input Text                          name:phone    ${EMPTY}
    Input Text                          name:phone    ${correct_phonenumber_count7}
    Page Should Not Contain Element     xpath://label[contains(text(),'A valid phone number may only contain numbers, +()')]
    Set Selenium Implicit Wait          3
    Capture Page Screenshot
    Input Text                          name:phone    ${EMPTY}
    Input Text                          name:phone    ${correct_phonenumber_count20}
    Page Should Not Contain Element     xpath://label[contains(text(),'A valid phone number may only contain numbers, +()')]
    Set Selenium Implicit Wait          3
    Capture Page Screenshot
    Input Text                          name:phone    ${EMPTY}
    Input Text                          name:phone    ${incorrect_phonenumber_count5}
    Page Should Contain Element         xpath://label[normalize-space()='The number you entered is not in range.']
    Set Selenium Implicit Wait          3
    Capture Page Screenshot
    Input Text                          name:phone    ${EMPTY}
    Input Text                          name:phone    ${incorrect_phonenumber_count21}
    Page Should Contain Element         xpath://label[normalize-space()='The number you entered is not in range.']
    Set Selenium Implicit Wait          3
    Capture Page Screenshot
    Input Text                          name:phone    ${EMPTY}
    Scroll Element Into View            xpath://input[@value='Submit']
    Submit Button
    Execute Javascript                  window.scrollBy(0,-200)
    Page Should Contain Element         xpath://div[@class='hs_phone hs-phone hs-fieldtype-phonenumber field hs-form-field']//label[@class='hs-error-msg hs-main-font-element'][normalize-space()='Please complete this required field.']
    Set Selenium Implicit Wait          3
    Capture Page Screenshot
    Execute Javascript                  window.scrollTo(0,-document.body.scrollHeight)
    Sleep                               1
    Reload Page
    Sleep                               1
    Execute Javascript                  window.scrollBy(0,600)
    Page Should Not Contain Element     xpath://div[@class='hs_phone hs-phone hs-fieldtype-phonenumber field hs-form-field']//label[@class='hs-error-msg hs-main-font-element'][normalize-space()='Please complete this required field.']
    Capture Page Screenshot
    Close Browser

*** Keywords ***
Submit Button
    Click Element    xpath://input[@value='Submit']