#!/bin/bash
# Declarei um array(STEPS) simulando o total de passos para a instalação.
# O "-r" é para dizer que é uma variável apenas de leitura
declare -r STEPS=('Upgrade do sistema' 'Node' 'VSCode' 'Chrome' 'Opera' 'Spotify' 'SimpleScreen' 'VLC' 'Postman' 'Mysql')

# Calculando o tamano do array
declare -r MAX_STEPS=${#STEPS[@]}

# Definindo o tamanho máximo da barra de carregamento
declare -r BAR_SIZE="##############"

# Calculando o tamanho da string que irá ser usada como barra de carregamento
declare -r MAX_BAR_SIZE=${#BAR_SIZE}

# Função para mostrar e gravar as etapas do script
log() {
   echo "$1" | tee -a /home/gonzaga/.config-sistema.txt
}
# Escondendo o cursor
tput civis -- invisible

log "Iniciando o processo de configuração do sistema." 
log "" 
# Loop para o calculo da barra de progresso
for step in "${!STEPS[@]}"; do
  # Calcula a porcentagem do loop corrente
  perc=$(((step + 1) * 100 / MAX_STEPS))
  # Calcula a quantidade de caracteres da barra, com base na porcentagem
  percBar=$((perc * MAX_BAR_SIZE / 100))
  # Instalação e controle de ambiente
  case $step in
  0)
    log "Fazendo upgrade do sistema operacional..."
    sudo apt-get update && sudo apt-get upgrade -y && sudo apt-get install net-tools -y && sudo apt-get install curl -y
  ;;
  1)
    log "Instalando Node.js..."
    sudo apt-get install node.js -y
  ;;
  2)
    log "Instalando VSCode..."
    sudo snap install --classic code
  ;;
  3)
    log "Instalando o Chrome..."
    cd /home/gonzaga/Downloads && sudo wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb && sudo dpkg -i google-chrome-stable_current_amd64.deb -y
  ;;
  4) 
    log "Instalando o Opera..."
    sudo snap install opera
  ;;
  5)
    log "Instalando spotify..."
    sudo snap install spotify
  ;;
  6)
    log "Instalando SimpleScreen..."
    sudo apt install simplescreenrecorder
  ;;
  7)
    log "Instalando VLC..."
    sudo snap install vlc
  ;;
  8)
    log "Instalando Postman..."
    sudo snap install postman
  ;;
  9)
    log "Instalando MySQL..."
    sudo apt install mysql-server
  ;;
  esac
  # Exibe a barra de progresso e a porcentagem do loop corrente
  # Flag "-e" serve para utilizar caracteristicas especiais do comando echo
  echo -e "[${BAR_SIZE:0:percBar}] $perc % - ${STEPS[$step]} \xE2\x9C\x94"
done
log ""

# Voltando o cursor ao normal
tput cnorm -- normal