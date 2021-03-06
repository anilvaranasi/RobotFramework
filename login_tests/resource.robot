*** Settings ***
Documentation     A resource file with reusable keywords and variables.
...
...               The system specific keywords created here form our own
...               domain specific language. They utilize keywords provided
...               by the imported SeleniumLibrary.
Library           SeleniumLibrary

*** Variables ***
${SERVER}         dev63486.service-now.com
${BROWSER}        Firefox
${DELAY}          0
${VALID USER}     candidate
${VALID PASSWORD}    candidate
${LOGIN URL}      https://${SERVER}/login.do
${WELCOME URL}    https://${SERVER}/navpage.do
${ERROR URL}      https://${SERVER}/error.html
${MAP URL}      https://${SERVER}/$sw_topology_map.do?sysparm_bsid=1cd2ffc8db739010bd8964d748961959&sysparm_bsname=Test&sysparm_plugin_mode=mapping&sysparm_service_source=csdm&sysparm_no_back=true

*** Keywords ***
Open Browser To Login Page
    Open Browser    ${LOGIN URL}    ${BROWSER}
    Maximize Browser Window
    Set Selenium Speed    ${DELAY}
    Login Page Should Be Open

Login Page Should Be Open
    Title Should Be    ServiceNow

Map Page Should Be Open
    Title Should Be    Topology Map

Go To Login Page
    Go To    ${LOGIN URL}
    Login Page Should Be Open

Input Username
    [Arguments]    ${username}
    Input Text    user_name    ${username}

Input Password
    [Arguments]    ${password}
    Input Text    user_password    ${password}

Submit Credentials
    Click Button    sysverb_login

Welcome Page Should Be Open
    #Location Should Be    ${WELCOME URL}
    Title Should Be    ServiceNow

Go To SerivceMapping Page
    Go To    ${MAP URL}
    Map Page Should Be Open

Input Filter
    [Arguments]   ${filterText}
    Input Text    filter    ${filterText}
    
Input Search
    [Arguments]    ${keyword}
    Input Text    filter    ${keyword}

Go To Application Services List Page
    [Arguments]    ${module}
    Click Button   ${module}

Find Index
   [Arguments]    ${element}    @{items}
   ${index} =    Set Variable    ${0}
   FOR    ${item}    IN    @{items}
       Return From Keyword If    '${item}' == '${element}'    ${index}
       ${index} =    Set Variable    ${index + 1}
   END
   Return From Keyword    ${-1}    # Also [Return] would work here.