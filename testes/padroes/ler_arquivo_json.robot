*** Settings ***

Library             OperatingSystem

*** Keywords ***

Ler Arquivo
	[Arguments]         ${json_file}
    ${dado_json}=         Get File                    ./testes/arquivos/json/${json_file}
    ${objeto}=            Evaluate                    json.loads('''${dado_json}''')           json
    [return]			${objeto}
