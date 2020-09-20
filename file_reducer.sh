#!/bin/bash

echo -e "\nIMPORTANTE: O arquivo referente a REDE CREDENCIADA precisa estar no mesmo diretório que este script\n"

echo "Informe o nome do arquivo final (recomendamos "nome_operadora.csv")..."
read nome_operadora;


echo -e "\nInforme o nome completo do arquivo de Rede credenciada (EX: "GM_MS_REDECRED_11092019_191355.CSV")"
read arquivo_rede_credenciada;

#criando o header do arquivo
sed -n '1p' $arquivo_rede_credenciada > $nome_operadora

echo -e "\n---- OPCOES ---- "
echo -e "\nQual a busca:
		1 - Especialidade (primeira coluna)
		2 - String (toda a linha)"
read opcao

if [ "$opcao" = "1" ] 
then
	echo -e "\nDigite a especialidade conforme é exibida na coluna de especialidade do cliente.
	Ex:
	Numero - 21;
	String - cardiologia\n"
	read especialidade
	esp_aux='"'"$especialidade"'"'

######## Varrendo o arquivo com string sem "aspas"
	sed -n "/^"$especialidade"/p" $arquivo_rede_credenciada >> $nome_operadora
	sleep 1;	

######## Varrendo o arquivo contatenando "aspas"
	sed -n "/^"$esp_aux"/p" $arquivo_rede_credenciada >> $nome_operadora
	sleep 1;

	echo -e "\nArquivo $nome_operadora gerado com sucesso..."
	exit

else

	echo -e "\nInforme o CPF/CNPJ do prestador Descredenciado (ou seja com data de bloqueio)"
	read prestador_descredenciado;

	echo -e "\nInforme o CPF/CNPJ do prestador  Substituto (ou seja o substituto do que foi descredenciado anteriormente)"
	read prestador_substituto;

########gerando arquivo com o descredenciado e subsituto
	grep "$prestador_descredenciado" $arquivo_rede_credenciada >> $nome_operadora
	sleep 1;
	grep "$prestador_substituto" $arquivo_rede_credenciada >> $nome_operadora
	sleep 1;

	echo -e "\narquivo $nome_operadora gerado com sucesso..."
	exit
fi

