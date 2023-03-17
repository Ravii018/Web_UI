*** Settings ***
Suite Setup       GET_JSONPARAMETERS_TIME
Metadata          Author    Raveendar P
Metadata          Email    raveendar.p@nokia.com
Library           Selenium2Library
Library           SSHLibrary
Library           DateTime
Library           parameters.py
Library           RemoteSwingLibrary
*** Variables ***
${SCREENSHOTS}    ${CURDIR}/Screenshots
@{NUM}            1    2    3    4    5    6    7    8    9    10    11    12    13    14    15    16    17
...               18    19    21    25    26
${App_path}       C:\\Users\\ravep\\Downloads
${Javaws}         C:\\Java\\jdk1.8.0_341\\bin\\javaws
${JAR}            C:\Users\ravep\AppData\Local\Programs\Python\Python38-32\Lib\site-packages\remoteswinglibrary-2.3.1.jar
*** Test Cases ***
ARD
    NETACT_STARTPAGE_LAUNCH
    Click Link    //a[@href='/fmreport/html/searchandresult.jsf?tab=1']
    Switch Window    title:Alarm Reports Dashboard - ${LABNAME} - omc
    Click Element    //a[@id='item3_label']
    Sleep    5s
    Capture Page Screenshot    ${SCREENSHOTS}/${LABNAME}/${DATE}/ARD.png
    Execute Javascript    window.scrollTo(0,200)
    Capture Page Screenshot    ${SCREENSHOTS}/${LABNAME}/${DATE}/ARD1.png
    [Teardown]    close browser

PHC
    [Setup]
    NETACT_STARTPAGE_LAUNCH
    Comment    Switch Window    title:NetAct™ Start Page - sprintlab564 - omc
    Click Link    //a[@href='/smu']
    Switch Window    title:System Monitoring - ${LABNAME} - omc
    Click Link    //a[@href='#phc']
    Wait Until Element Is Enabled    //tbody/tr[@class='ng-scope']/td/span
    ${REPORT_DATE_TIME}    Get Text    //tbody/tr[@class='ng-scope']/td/span
    log    ${REPORT_DATE_TIME}
    ${REPORT_DATE}    Convert Date    ${REPORT_DATE_TIME}    exclude_millis=yes    result_format=%Y-%m-%d
    ${TIME}=    Get Current Date
    ${EXP_DATE}=    Convert Date    ${TIME}=    exclude_millis=yes    result_format=%Y-%m-%d
    BuiltIn.Run Keyword If    '${EXP_DATE}' != '${REPORT_DATE}'    CREATE_REPORT
    Wait Until Element Is Enabled    //td/a[contains(text(),'Open report')]
    Click Link    //td/a[contains(text(),'Open report')]
    Switch Window    title:Preventive Health Check Tool for NetAct
    Sleep    5s
    Wait Until Element Is Enabled    //div[@class='dropdown-title-handle']
    Click Element    //div[@class='dropdown-title-handle']
    Click Element    //span[contains(text(),'Failed tests')]
    Capture Page Screenshot    ${SCREENSHOTS}/${LABNAME}/${DATE}/PHC.png
    FOR    ${i}    IN    @{NUM}
        ${Value}    Get Value    id:menu-${i}-failed
        Run Keyword If    ${Value}>0    Click Element    id:a-menu-${i}
        ${TEXT}    Get Text    //a[@id='a-menu-${i}']/span
        Run Keyword If    ${Value}>0    Capture Page Screenshot    ${SCREENSHOTS}/${LABNAME}/${DATE}/${TEXT}.png
    END
    Comment    ${Value}    Get Value    id:menu-10-failed
    Comment    Click Element    id:a-menu-10
    Comment    FOR    ${i}    IN    @{DECI}
    Comment    \    ${Value}    Get Value    //input[@id='menu-${i}-failed']
    Comment    \    Run Keyword If    ${Value}>0    Click Element    //li[@id='menu-${i}']
    Comment    END
    [Teardown]    Close Browser

SWM
    NETACT_STARTPAGE_LAUNCH
    Click Link    //a[@href='/swm-web']
    Switch Window    title:Software Manager - ${LABNAME} - omc
    Click Element    //a[@href='/swm-web/html/tasks/view.xhtml']
    Sleep    5s
    Input Text    //input[@id='TViewCombo:cccomboboxField']    MRBT
    Press Keys    //input[@id='TViewCombo:cccomboboxField']    DOWN
    Press Keys    //input[@id='TViewCombo:cccomboboxField']    ENTER
    Sleep    5s
    Wait Until Element Is Visible    //input[@id='taskTypeFilterId_comboButton_id']
    Wait Until Element Is Enabled    //input[@id='taskTypeFilterId_comboButton_id']
    Click button    //input[@id='taskTypeFilterId_comboButton_id']
    Select Checkbox    //input[@id='TView:taskTypeFilterId_multicheckbox_id:0']
    Select Checkbox    //input[@id='TView:taskTypeFilterId_multicheckbox_id:2']
    Select Checkbox    //input[@id='TView:taskTypeFilterId_multicheckbox_id:5']
    Click Button    //input[@id='TView:taskTypeFilterId_apply_button']
    sleep    10s
    Capture Page Screenshot    ${SCREENSHOTS}/${LABNAME}/${DATE}/SWM.png
    [Teardown]    Close Browser

SWAM
    NETACT_STARTPAGE_LAUNCH
    Click Element    //a[@href='/SWAMClient']
    Switch Window    title:Software Asset Monitoring - ${LABNAME} - omc
    Capture Page Screenshot    ${SCREENSHOTS}/${LABNAME}/${DATE}/SWAM.png
    Execute Javascript    window.scrollTo(0,400)
    Capture Page Screenshot    ${SCREENSHOTS}/${LABNAME}/${DATE}/SWAM1.png
    Click Element    //a[@id='report:reportsForm:reportResultTable:0:0:viewButton']
    ${TEXT}    Get Text    //td[@id='report:reportsForm:reportResultTable:0:0:monitoredTimeColumn']
    Switch Window    title:Software Asset Monitoring - Report details - Summary report - ${TEXT} - ${LABNAME} - omc
    Capture Page Screenshot    ${SCREENSHOTS}/${LABNAME}/${DATE}/SWAM_REPORT.png
    [Teardown]    Close Browser

CNUM
    NETACT_STARTPAGE_LAUNCH
    Click Element    //a[@href='/NetworkElementAccessControl']
    Switch Window    title:Network Element Access Control - ${LABNAME} - omc
    Click Element    //td[@id='centralizedNEUserMgmt_lbl']
    Sleep    5s
    Wait Until Element Is Visible    //input[@id='cnumList:dataTableCnum:cnumStatusFilterBox']
    Input Text    //input[@id='cnumList:dataTableCnum:cnumStatusFilterBox']    Activated
    Press Keys    //input[@id='cnumList:dataTableCnum:cnumStatusFilterBox']    ENTER
    Sleep    10s
    Wait Until Element Is Enabled    //td[@class=' rich-datascr-button']/img[@id='cnumList:dataTableCnum:last_img']
    Sleep    5s
    Click Element    //td[@class=' rich-datascr-button']/img[@id='cnumList:dataTableCnum:last_img']
    Sleep    5s
    Execute Javascript    window.scrollTo(0,400)
    Capture Page Screenshot    ${SCREENSHOTS}/${LABNAME}/${DATE}/CNUM.png
    [Teardown]    close browser

FM
    [Setup]
    PAF_LAUNCH
    Wait Until Element Is Visible    //input[@class='css-1m7hyr']
    Input Text    //input[@class='css-1m7hyr']    NetACt Analysis - FM
    Wait Until Element Is Visible    //div[contains(text(),'NetAct Analysis - FM')]
    Click Element    //div[contains(text(),'NetAct Analysis - FM')]
    Sleep    10s
    Wait Until Element Is Visible    //div[5]/div/value-select-dropdown/div/a[@class='variable-value-link']
    Click Element    //div[5]/div/value-select-dropdown/div/a[@class='variable-value-link']
    Sleep    10s
    Switch Window    title:Performance Analysis Service - Start Page
    Switch Window    title:NetAct Analysis - FM - Grafana
    Wait Until Element Is Visible    //div[5]/div/value-select-dropdown/div/input[@class='gf-form-input ng-pristine ng-valid ng-empty ng-touched']
    Comment    Click Element    //div[5]/div/value-select-dropdown/div/input[@class='gf-form-input ng-pristine ng-valid ng-empty ng-touched']
    Comment    Input Text    //div[5]/div/value-select-dropdown/div[@class='variable-link-wrapper']    ${LABNAME}
    Input Text    //div[5]/div/value-select-dropdown/div/input[@class='gf-form-input ng-pristine ng-valid ng-empty ng-touched']    ${LABNAME}
    Comment    Input Text    //input[@class='gf-form-input ng-pristine ng-valid ng-empty ng-touched']    ${LABNAME}
    Press Keys    //input[@class='gf-form-input ng-valid ng-touched ng-not-empty ng-dirty ng-valid-parse']    DOWN+ENTER
    Sleep    10s
    Capture Page Screenshot    ${SCREENSHOTS}/${LABNAME}/${DATE}/FM.png
    [Teardown]    Close Browser

PM
    PAF_LAUNCH
    Wait Until Element Is Visible    //input[@class='css-1m7hyr']
    Input Text    //input[@class='css-1m7hyr']    NetAct Analysis - PM Aggregation
    Wait Until Element Is Visible    //div[contains(text(),'NetAct Analysis - PM Aggregation')]
    Click Element    //div[contains(text(),'NetAct Analysis - PM Aggregation')]
    Sleep    10s
    Wait Until Element Is Visible    //div[5]/div/value-select-dropdown/div[@class='variable-link-wrapper']
    Click Element    //div[5]/div/value-select-dropdown/div[@class='variable-link-wrapper']
    Sleep    10s
    Switch Window    title:Performance Analysis Service - Start Page
    Switch Window    title:NetAct Analysis - PM Aggregation - Grafana
    Set Selenium Timeout    30s
    Wait Until Element Is Visible    //div[5]/div/value-select-dropdown/div/input[@class='gf-form-input ng-pristine ng-valid ng-empty ng-touched']
    Input Text    //div[5]/div/value-select-dropdown/div/input[@class='gf-form-input ng-pristine ng-valid ng-empty ng-touched']    ${LABNAME}
    Press Keys    //input[@class='gf-form-input ng-valid ng-touched ng-not-empty ng-dirty ng-valid-parse']    DOWN+ENTER
    Sleep    10s
    Capture Page Screenshot    ${SCREENSHOTS}/${LABNAME}/${DATE}/PM_Aggregation.png
    Click Element    //a[contains(text(),'NetAct Analysis - PM Aggregation')]
    Wait Until Element Is Visible    //input[@class='css-1m7hyr']
    Input Text    //input[@class='css-1m7hyr']    NetAct Analysis - PM Pipe
    Wait Until Element Is Visible    //div[contains(text(),'NetAct Analysis - PM Pipe')]
    Click Element    //div[contains(text(),'NetAct Analysis - PM Pipe')]
    Sleep    10s
    Set Selenium Implicit Wait    15s
    Wait Until Element Is Visible    //div[5]/div/value-select-dropdown/div[@class='variable-link-wrapper']
    Click Element    //div[5]/div/value-select-dropdown/div[@class='variable-link-wrapper']
    Switch Window    title:Performance Analysis Service - Start Page
    Switch Window    title:NetAct Analysis - PM Pipe - Grafana
    Sleep    10s
    Set Selenium Timeout    30s
    Wait Until Element Is Visible    //div[5]/div/value-select-dropdown/div/input[@class='gf-form-input ng-pristine ng-valid ng-empty ng-touched']
    Input Text    //div[5]/div/value-select-dropdown/div/input[@class='gf-form-input ng-pristine ng-valid ng-empty ng-touched']    ${LABNAME}
    Press Keys    //input[@class='gf-form-input ng-valid ng-touched ng-not-empty ng-dirty ng-valid-parse']    DOWN+ENTER
    Sleep    10s
    Capture Page Screenshot    ${SCREENSHOTS}/${LABNAME}/${DATE}/PM_Pipe.png
    [Teardown]    Close Browser

3GPPFMNBI
    PAF_LAUNCH
    Wait Until Element Is Visible    //input[@class='css-1m7hyr']
    Input Text    //input[@class='css-1m7hyr']    NBI3GPP FM
    Wait Until Element Is Visible    //div[contains(text(),'NBI3GPP FM')]
    Click Element    //div[contains(text(),'NBI3GPP FM')]
    Sleep    10s
    Wait Until Element Is Visible    //div[5]/div/value-select-dropdown/div[@class='variable-link-wrapper']
    Click Element    //div[5]/div/value-select-dropdown/div[@class='variable-link-wrapper']
    Sleep    10s
    Switch Window    title:Performance Analysis Service - Start Page
    Switch Window    title:NBI3GPP FM - Grafana
    Set Selenium Timeout    30s
    Wait Until Element Is Visible    //div[5]/div/value-select-dropdown/div/input[@class='gf-form-input ng-pristine ng-valid ng-empty ng-touched']
    Input Text    //div[5]/div/value-select-dropdown/div/input[@class='gf-form-input ng-pristine ng-valid ng-empty ng-touched']    ${LABNAME}
    Press Keys    //input[@class='gf-form-input ng-valid ng-touched ng-not-empty ng-dirty ng-valid-parse']    DOWN+ENTER
    Click Element    //span[contains(text(),'Alarms per Second for Latest 1 Minute (node: All)')]
    Click Element    //span[contains(text(),'View')]
    Sleep    10s
    Capture Page Screenshot    ${SCREENSHOTS}/${LABNAME}/${DATE}/3GPPFMNBI.png
    [Teardown]    Close Browser

SNMPNBI
    PAF_LAUNCH
    Wait Until Element Is Visible    //input[@class='css-1m7hyr']
    Input Text    //input[@class='css-1m7hyr']    NBISNMP
    Wait Until Element Is Visible    //div[contains(text(),'NBISNMP')]
    Click Element    //div[contains(text(),'NBISNMP')]
    Sleep    10s
    Wait Until Element Is Visible    //div[5]/div/value-select-dropdown/div[@class='variable-link-wrapper']
    Click Element    //div[5]/div/value-select-dropdown/div[@class='variable-link-wrapper']
    Sleep    10s
    Switch Window    title:Performance Analysis Service - Start Page
    Switch Window    title:NBISNMP - Grafana
    Set Selenium Timeout    30s
    Wait Until Element Is Visible    //div[5]/div/value-select-dropdown/div/input[@class='gf-form-input ng-pristine ng-valid ng-empty ng-touched']
    Input Text    //div[5]/div/value-select-dropdown/div/input[@class='gf-form-input ng-pristine ng-valid ng-empty ng-touched']    ${LABNAME}
    Press Keys    //input[@class='gf-form-input ng-valid ng-touched ng-not-empty ng-dirty ng-valid-parse']    DOWN+ENTER
    Click Element    //span[contains(text(),'Processed notifications (node: All)')]
    Click Element    //span[contains(text(),'View')]
    Sleep    10s
    Capture Page Screenshot    ${SCREENSHOTS}/${LABNAME}/${DATE}/SNMPNBI.png
    [Teardown]    Close Browser

Monitor
    Comment    Start Application    Monitor    ${Javaws} ${App_path}/racpmc.jnlp    timeout=180
    RemoteSwingLibrary.Start Application    CM Operations Manager    ${Javaws} ${App_path}\\racpmc.jnlp
    Select From Popup Menu    Security Warning    DISMISS
*** Keywords ***
GET_JSONPARAMETERS_TIME
    ${TIME}=    Get Current Date
    ${DATE}=    Convert Date    ${TIME}=    exclude_millis=yes    result_format=%y%m%d_%H%M
    BuiltIn.Set Global Variable    ${DATE}
    ${LABNAME}    ${URL}    ${USERNAME}    ${PASSWORD}    ${PAF_USERNAME}    ${PAF_PASSWORD}    Parameters
    BuiltIn.Set Global Variable    ${LABNAME}
    BuiltIn.Set Global Variable    ${URL}
    BuiltIn.Set Global Variable    ${USERNAME}
    BuiltIn.Set Global Variable    ${PASSWORD}
    BuiltIn.Set Global Variable    ${PAF_USERNAME}
    BuiltIn.Set Global Variable    ${PAF_PASSWORD}
    [Return]    ${DATE}    ${LABNAME}    ${URL}    ${USER_NAME}    ${PASSWORD}    ${PAF_USERNAME}    ${PAF_PASSWORD}

NETACT_STARTPAGE_LAUNCH
    ${hlb}=    BuiltIn.Set Variable    headlesschrome
    ${nb}=    BuiltIn.Set Variable    chrome
    ${chrome_options} =    BuiltIn.Evaluate    sys.modules['selenium.webdriver'].ChromeOptions()
    Call Method    ${chrome_options}    add_argument    --disable-extensions
    Call Method    ${chrome_options}    add_argument    --ignore-certificate-errors
    ${headless}    Chrome Type
    Comment    ${headless}    BuiltIn.Set Variable    0
    Run Keyword If    '${headless}' == '1'    Call Method    ${chrome_options}    add_argument    --headless\n
    Call Method    ${chrome_options}    add_argument    --disable-gpu
    Comment    Call Method    ${chrome_options}    add_argument    --start-maximized
    Call Method    ${chrome_options}    add_argument    window-size\=1200,800
    Open Browser    ${URL}    ${nb}    options=${chrome_options}
    Comment    ${SIZE}=    Selenium2Library.Get Window Size
    Maximize Browser Window
    Comment    Selenium2Library.Set Window Size    ${1050}    ${660}
    Comment    Maximize Browser Window
    Comment    ${SIZE}=    Selenium2Library.Get Window Size
    Comment    Click Button    id:details-button
    Comment    Click Link    id:proceed-link
    Set Selenium Timeout    20s
    Comment    BuiltIn.Set Global Variable    ${USERNAME}
    Comment    ${USERNAME}    Parameters
    Comment    ${USERNAME}    BuiltIn.Set Global Variable    ${USERNAME}
    Wait Until Element Is Visible    //input[@id='login:username']
    Input Text    //input[@id='login:username']    ${USERNAME}
    Input Text    //input[@id='login:password']    ${PASSWORD}
    Click Button    //input[@id='login:loginButton']
    sleep    2s
    Click Button    //input[@id='login:legalPanelCloseButton']
    Click Link    //a[@id='linkShowAppFolder']
    Click Link    //a[@class='menuItem2']

PAF_LAUNCH
    ${hlb}=    BuiltIn.Set Variable    headlesschrome
    ${nb}=    BuiltIn.Set Variable    chrome
    ${chrome_options} =    BuiltIn.Evaluate    sys.modules['selenium.webdriver'].ChromeOptions()
    Call Method    ${chrome_options}    add_argument    --disable-extensions
    Call Method    ${chrome_options}    add_argument    --ignore-certificate-errors
    Comment    Call Method    ${chrome_options}    add_argument    --headless
    Call Method    ${chrome_options}    add_argument    --disable-gpu
    Comment    Call Method    ${chrome_options}    add_argument    --start-maximized
    Call Method    ${chrome_options}    add_argument    window-size\=1200,800
    Open Browser    https://paf.netact.nsn-rdnet.net/authn/index.html    ${nb}    options=${chrome_options}
    Maximize Browser Window
    Comment    Click Button    //button[@id='details-button']
    Comment    Click Link    //a[@id='proceed-link']
    Comment    ${PAF_USERNAME}    ${LABNAME}    main.Parameters
    Comment    ${PAF_USERNAME}    BuiltIn.Set Global Variable    ${PAF_USERNAME}
    Wait Until Element Is Visible    //input[@id='httpd_username']
    Input Text    //input[@id='httpd_username']    ${PAF_USERNAME}
    Input Text    //input[@id='httpd_password']    ${PAF_PASSWORD}
    Click button    //button[@name='login']
    Click Element    //img[@src='/images/PAF_Grafana.png']
    Switch Window    title:Home - Grafana
    Click Element    //i[@class='fa fa-caret-down navbar-page-btn__search']

CREATE_REPORT
    Wait Until Element Is Enabled    //button[@class='btn btn-standard']
    Click button    //button[@class='btn btn-standard']
    Sleep    2s
    Click button    //button[@class='btn btn-standard dialog-button ng-binding ng-scope']
    Comment    Sleep    15m
    Set Selenium Timeout    30m
    Wait Until Element Is Enabled    //button[@class='btn btn-standard']
