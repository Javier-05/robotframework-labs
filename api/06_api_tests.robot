*** Settings ***
Library    RequestsLibrary
Library    Collections

*** Variables ***
${BASE_URL}    https://reqres.in
${API_KEY}     free_user_3G7IJw3QWWyO5fG9UVi2DtxKWGI

*** Test Cases ***
Obtener Lista De Usuarios
    ${headers}=    Create Dictionary    x-api-key=${API_KEY}    Content-Type=application/json
    Create Session    reqres    ${BASE_URL}    headers=${headers}    verify=${False}
    ${response}=    GET On Session    reqres    url=/api/users    params=page=2
    Status Should Be    200    ${response}
    ${body}=    Set Variable    ${response.json()}
    Should Be True    ${body}[total] > 0

Crear Nuevo Usuario
    ${headers}=    Create Dictionary    x-api-key=${API_KEY}    Content-Type=application/json
    Create Session    reqres    ${BASE_URL}    headers=${headers}    verify=${False}
    &{payload}=    Create Dictionary    name=Carlos    job=QA Engineer
    ${response}=    POST On Session    reqres    /api/users    json=${payload}
    Status Should Be    201    ${response}
    ${body}=    Set Variable    ${response.json()}
    Should Be Equal    ${body}[name]    Carlos

Obtener Usuario Inexistente
    ${headers}=    Create Dictionary    x-api-key=${API_KEY}    Content-Type=application/json
    Create Session    reqres    ${BASE_URL}    headers=${headers}    verify=${False}
    ${response}=    GET On Session    reqres    /api/unknown/999    expected_status=404
    Status Should Be    404    ${response}