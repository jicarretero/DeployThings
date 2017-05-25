# Uso:
Para instalar mysql, 
    ansible-playbook -i ../../inventory install_mysql.yml

Para crear bases de datos, tenemos que definir un fichero con descripción de bases de datos definidas:
    ansible-playbook -i ../../inventory -e databases_file=./default/databases.yml  createdatabases.yml  

