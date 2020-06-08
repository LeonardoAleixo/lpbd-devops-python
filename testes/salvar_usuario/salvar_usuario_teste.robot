*** Settings ***

Resource     ../padroes/ler_arquivo_json.robot
Resource     ../padroes/variaveis.robot
Resource     ../padroes/chamar_post.robot
Resource     ../padroes/chamar_get.robot
Resource     ../padroes/validacao.robot
Library      ../padroes/deploy.py

*** Variables ***
${DEPLOY}=      1

***Test Cases***

#
# Alterado LPBD - Douglas Nishiama - 20/05/2019 
# Casos de teste para verificar todos os erros retornados pelo Webservice
# Criar em linguagem Robot framework
#
Salvar Usuario Nome Nao Preenchido
    ${corpo}=     Ler Arquivo  ${USUARIO_NOME_NAO_PREENCHIDO}
    ${resposta}=        Chamar post     ${corpo}     ${URL_SALVAR_USUARIO}
    Validar Requisicao  ${resposta.status_code}    ${ERRO_400}
    Validar Requisicao  ${resposta.text}    ${MSG_USUARIO_NOME_NAO_PREENCHIDO}

Salvar Usuario Sobrenome Nao Preenchido
    ${corpo}=     Ler Arquivo  ${USUARIO_SOBRENOME_NAO_PREENCHIDO}
    ${resposta}=        Chamar post     ${corpo}     ${URL_SALVAR_USUARIO}
    Validar Requisicao  ${resposta.status_code}    ${ERRO_400}  
    Validar Requisicao  ${resposta.text}    ${MSG_USUARIO_SOBRENOME_NAO_PREENCHIDO}

Salvar Usuario Data Nao Preenchida
    ${corpo}=     Ler Arquivo  ${USUARIO_IDADE_NAO_PREENCHIDA}
    ${resposta}=        Chamar post     ${corpo}     ${URL_SALVAR_USUARIO}
    Validar Requisicao  ${resposta.status_code}    ${ERRO_400}
    Validar Requisicao  ${resposta.text}    ${MSG_USUARIO_IDADE_NAO_PREENCHIDA}


Salvar Usuario Cpf Invalido
    ${corpo}=     Ler Arquivo  ${USUARIO_CPF_INVALIDO}
    ${resposta}=        Chamar post     ${corpo}     ${URL_SALVAR_USUARIO}
    Validar Requisicao  ${resposta.status_code}    ${ERRO_400}
    Validar Requisicao  ${resposta.text}    ${MSG_CPF_INVALIDO}


Salvar Usuario Telefone Nao Preenchido
    ${corpo}=     Ler Arquivo  ${USUARIO_TELEFONE_NAO_PREENCHIDo}
    ${resposta}=        Chamar post     ${corpo}     ${URL_SALVAR_USUARIO}
    Validar Requisicao  ${resposta.status_code}    ${ERRO_400}
    Validar Requisicao  ${resposta.text}    ${MSG_TELEFONE_NAO_PREENCHIDO}

Salvar Usuario Idade Invalida
    ${corpo}=     Ler Arquivo  ${USUARIO_IDADE_ERRADA}
    ${resposta}=        Chamar post     ${corpo}     ${URL_SALVAR_USUARIO}
    Validar Requisicao  ${resposta.status_code}    ${ERRO_400}
    Validar Requisicao  ${resposta.text}    ${MSG_USUARIO_IDADE_ERRADA}

Salvar Usuario Sucesso
    ${corpo}=     Ler Arquivo  ${USUARIO_SUCESSO}
    ${resposta}=        Chamar post     ${corpo}     ${URL_SALVAR_USUARIO}
    Validar Requisicao  ${resposta.status_code}    ${SUCESSO_200}

Buscar Usuario Sucesso
    ${resposta}=        Chamar get     1     ${URL_GET_USUARIO_ID}
    Validar Requisicao  ${resposta.status_code}    ${SUCESSO_200}

Buscar ID Inexistente
    ${resposta}=        Chamar get     0     ${URL_GET_USUARIO_ID}
    Validar Requisicao  ${resposta.status_code}    ${ERRO_400}


# Validar Deploy
#     Run keyword if    "${DEPLOY}" == "1"   Deploy


***Keywords ***


Validar Requisicao
    [Arguments]     ${resp1}   ${esp1}
    Run keyword if  "${resp1}" != "${esp1}"     Invalidar Deploy

Invalidar Deploy
    ${DEPLOY}=      0

