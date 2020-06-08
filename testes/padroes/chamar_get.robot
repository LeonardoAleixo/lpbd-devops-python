*** Settings ***
Library             Collections
Library             RequestsLibrary
Library             OperatingSystem
Resource            variaveis.robot

*** Variables ***

${user}=        ${USUARIO_CORRETO}
${pass}=        ${SENHA_CORRETA}

***Keywords***

Chamar get
    [Arguments]         ${id}         ${url}     
    # this kyword is in the Strings library
    ${userpass}=    Convert To Bytes    ${user}:${pass}   # this is the combined string will be base64 encode
    ${userpass}=    Evaluate    base64.b64encode($userpass)    base64

    Create Session      sessao             ${URI_BASE_USUARIO_LOCAL}  
    
    ${headers}=         Create Dictionary       Content-Type=application/json

    # add the new Authorization header
    Set To Dictionary    ${headers}    Authorization    Basic ${userpass}

	${response}=        Get Request			sessao			${url}${id}/			data=${id}         headers=${headers}
                              
	[return]			${response}