*** Settings ***
Library    RequestsLibrary
Library    SeleniumLibrary
Resource   ui/login_page.resource
Suite Setup       Configuracion Inicial Regresion
Suite Teardown    Cierre Inicial Regresion
Test Tags         regresion

*** Variables ***
${BASE_URL}       https://reqres.in
${API_KEY}        free_user_3G7IJw3QWWyO5fG9UVi2DtxKWGI
${URL_UI}         https://www.saucedemo.com
${BROWSER}        chrome

*** Test Cases ***
Regresion API - Obtener Lista De Usuarios
    ${headers}=    Create Dictionary    x-api-key=${API_KEY}    Content-Type=application/json
    Create Session    reqres    ${BASE_URL}    headers=${headers}    verify=${False}
    ${response}=    GET On Session    reqres    url=/api/users    params=page=2
    Status Should Be    200    ${response}

Regresion API - Crear Nuevo Usuario
    ${headers}=    Create Dictionary    x-api-key=${API_KEY}    Content-Type=application/json
    Create Session    reqres    ${BASE_URL}    headers=${headers}    verify=${False}
    &{payload}=    Create Dictionary    name=Carlos    job=QA Engineer
    ${response}=    POST On Session    reqres    /api/users    json=${payload}
    Status Should Be    201    ${response}

Regresion UI - Login Exitoso
    Go To    ${URL_UI}
    Ingresar Credenciales    standard_user    secret_sauce
    Wait Until Page Contains    Products    timeout=10s

*** Keywords ***
Configuracion Inicial Regresion
    ${options}=    Evaluate    sys.modules['selenium.webdriver'].ChromeOptions()    sys, selenium.webdriver
    Open Browser    about:blank    ${BROWSER}    options=${options}
    Maximize Browser Window

Cierre Inicial Regresion
    Close All Browsers