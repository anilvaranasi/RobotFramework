*** Settings ***
Documentation     A test suite with a single test for valid login.
...
...               This test has a workflow that is created using keywords in
...               the imported resource file.
Resource          resource.robot
*** Variables ***
@{LIST} =    foo    baz

*** Test Cases ***
Valid Login
    Open Browser To Login Page
    Go To Login Page
    Input Username    candidate
    Input Password    candidate
    Submit Credentials
    Welcome Page Should Be Open
    #Input Filter   application services
    Input Search    n ser
    ${index} =    Find Index    baz    @{LIST}
    Should Be Equal    ${index}    ${1}
    ${index} =    Find Index    non existing    @{LIST}
    Should Be Equal    ${index}    ${-1}
    Go To SerivceMapping Page
    
    [Teardown]    Close Browser