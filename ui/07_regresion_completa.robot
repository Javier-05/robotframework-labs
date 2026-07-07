*** Settings ***
Library    RequestsLibrary
Library    Collections
Library    SeleniumLibrary
Resource   ui/login_page.resource

Suite Setup       Configuracion Inicial Regresion
Suite Teardown    Cierre Inicial Regresion
Test Tags         regresion

*** Variables ***
${BASE_URL}    https://reqres.in
${API_KEY}     free_user_3G7IJw3QWWyO5fG9UVi2DtxKWGI
${URL}         https://www.saucedemo.com
${BROWSER}     headlesschrome

*** Test Cases ***
Regresion API - Obtener Lista De Usuarios
    ${headers}=    Create Dictionary    x-api-key=${API_KEY}    Content-Type=application/json
    Create Session    reqres    ${BASE_URL}    headers=${headers}    verify=${False}
    ${response}=    GET On Session    reqres    url=/api/users    params=page=2
    Status Should Be    200    ${response}
    ${body}=    Set Variable    ${response.json()}
    Should Be True    ${body}[total] > 0

Regresion API - Crear Nuevo Usuario
    ${headers}=    Create Dictionary    x-api-key=${API_KEY}    Content-Type=application/json
    Create Session    reqres    ${BASE_URL}    headers=${headers}    verify=${False}
    &{payload}=    Create Dictionary    name=Carlos    job=QA Engineer
    ${response}=    POST On Session    reqres    /api/users    json=${payload}
    Status Should Be    201    ${response}
    ${body}=    Set Variable    ${response.json()}
    Should Be Equal    ${body}[name]    Carlos

Regresion UI - Login Y Agregar Producto Al Carrito
    Abrir Sitio Swag Labs
    Login Exitoso
    Agregar Backpack Al Carrito
    Verificar Carrito Con Un Producto

*** Keywords ***
Configuracion Inicial Regresion
    No Operation

Cierre Inicial Regresion
    Close All Browsers

Abrir Sitio Swag Labs
    Open Browser    ${URL}    ${BROWSER}
    Maximize Browser Window