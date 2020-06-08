import zipfile
import os
import time
from termcolor import colored


page_base_dev_ops = "C:\\Users\\Aleixo\\Documents\\desenvolvimento\\lpbd\\dev-ops\\"

path_dump = page_base_dev_ops + "lpbd.sql"
path_teste = "C:\\Users\\Aleixo\\Documents\\ambiente\\teste\\"
path_teste_deploy = "C:\\Users\\Aleixo\\Documents\\ambiente\\teste\\apache-tomcat-9.0.35\\webapps"
path_teste_bin = "C:\\Users\\Aleixo\\Documents\\ambiente\\teste\\apache-tomcat-9.0.35\\bin"
path_apache = page_base_dev_ops + "testes\\arquivos\\apache-tomcat-9.zip"
path_mysql = "C:\\Program Files\MySQL\\MySQL Server 8.0\\bin\\"
path_project = "C:\\Users\\Aleixo\\Documents\\desenvolvimento\\lpbd\\LPBD"
path_war = "C:\\Users\\Aleixo\\Documents\\desenvolvimento\\lpbd\\LPBD\\target\\LPBD-0.0.1-SNAPSHOT.war"
path_activate = page_base_dev_ops + "venv\\Scripts\\activate.bat"
path_venv = page_base_dev_ops + "venv\\"
path_requirements = page_base_dev_ops
path_teste_robot = page_base_dev_ops + "testes\\salvar_usuario\\salvar_usuario_teste.robot"

def startTeste(tempo):
    print(colored("Teste iniciando em: " + str(tempo) + " seg", 'green'))
    if tempo == 0:
        openVenv()
    else:
        time.sleep(1)
        startTeste(tempo - 1)

def instalarDependencias():
    global path_activate
    global path_venv
    global path_requirements
    os.system("rd /s /q " + path_venv)
    os.system(path_activate)
    os.chdir(path_requirements)
    os.system('pip install -r requirements.txt')

def openVenv():
    print(colored("Iniciando instalação e execução dos testes automáticos...", 'green'))
    global path_teste_robot
    global path_requirements
    os.chdir(path_requirements)
    os.system('robot ' + path_teste_robot)

def moverWarTesteStart():
    print(colored("Copiando projeto para servidor de teste...", 'green'))
    global path_war
    global path_teste_deploy
    global path_teste_bin
    os.system("copy " + path_war + " " + path_teste_deploy + "\\ROOT.war")
    os.chdir(path_teste_bin)
    os.system("rd /s /q " + path_teste_deploy + "\\ROOT\\")
    os.system("startup")
    startTeste(30)

def buildarWar():
    print(colored("Iniciando Build do projeto...", "green"))
    global path_project
    os.chdir(path_project)
    os.system("mvn clean install")

def extrairApacheTeste():
    print(colored("Extraindo servidor de aplicação...", 'green'))
    global path_apache
    global path_teste
    with zipfile.ZipFile(path_apache, 'r') as zip_ref:
        zip_ref.extractall(path_teste)

def criarDiretorioTeste():
    print(colored("Criando diretório do ambiente de Teste...", 'green'))
    global path_teste
    os.system("rd /s /q " +path_teste)
    if not os.path.exists(path_teste):
        os.makedirs(path_teste)


'''
    -- Alterado LPBD - Sandro Toline - 31/05/2019 
    -- Script para restaurar o banco de dados sem nenhum dado.
'''
def restaurarBanco():
    instalarDependencias()
    print(colored("Restaurando o banco de dados...", 'green'))
    global path_mysql
    global path_dump
    os.chdir(path_mysql)
    comando = "mysql -uroot -pAleixo@123 lpbd < " + path_dump
    os.system(comando)


restaurarBanco()
criarDiretorioTeste()
buildarWar()
extrairApacheTeste()
moverWarTesteStart()