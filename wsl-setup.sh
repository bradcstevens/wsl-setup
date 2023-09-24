# Set Terminal Hostname to Distro
DISTRO=$(( lsb_release -ds || cat /etc/*release || uname -om ) 2>/dev/null | head -n1 | sed -e 's/\s\+/-/g')

(echo; echo 'export PS1="\033[32m\]\u@'$DISTRO'\[\033[00m\]:\[\033[34m\]\w\[\033[00m\]$ "') >> ~/.profile

source ~/.profile

# Updates
sudo apt update && sudo apt upgrade -y
sudo apt-get install build-essential -y

# Setup Aliases
(echo; echo 'if [ -e $HOME/.bash_aliases ]; then
    source $HOME/.bash_aliases
fi') >> ~/.bashrc

touch ~/.bash_aliases

(echo "alias ..='cd ..'
alias ls='ls -hF --color'
alias la='ls -Al'
alias lx='ls -lXB'
alias lk='ls -lSr'
alias lc='ls -lcr'
alias lu='ls -lur'
alias lr='ls -lR'
alias lt='ls -ltr'
alias lm='ls -al |more'
alias tree='tree -Csu'
alias dir='ls -lrt'
alias h='history'
alias p='pwd -P'
alias cls='clear'
alias env='clear && env | sort'
alias ps='ps -A'
alias python='python3'
alias py='python'
alias pip='pip3'
alias mkdir='mkdir -p'
alias azl='az login --service-principal -u "'$AZ_CLIENT_ID'" -p "'$AZ_CLIENT_SECRET'" --tenant "'$AZ_TENANT_ID'"'
alias path='"'echo -e ${PATH//:/\\n}'"'") >> ~/.bash_aliases

(echo; echo 'if [ -e $HOME/.bash_aliases ]; then
    source $HOME/.bash_aliases
fi') >> ~/.bashrc

(echo; echo 'export PATH=$PATH:~/.local/bin') >> ~/.bashrc

(echo; echo 'source ~/.env
azl
cls') >> ~/.bashrc

source ~/.bashrc

# Install Homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

(echo; echo 'eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"') >> ~/.profile

eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"

# Install Azure CLI
curl -sL https://aka.ms/InstallAzureCLIDeb | sudo bash

# Instll Packages
brew update && brew install tree gcc python git docker docker-machine node nvm gh helm kubectl derailed/k9s/k9s
