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
brew update && brew install tree gcc python git docker docker-machine node nvm gh helm kubectl derailed/k9s/k9s kustomize pyenv

git config --global user.email "brad@bradcstevens.com"
git config --global user.name "Brad Stevens"

curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.gpg
sudo mv microsoft.gpg /etc/apt/trusted.gpg.d/microsoft.gpg

sudo sh -c 'echo "deb [arch=amd64] https://packages.microsoft.com/repos/microsoft-ubuntu-$(lsb_release -cs)-prod $(lsb_release -cs) main" > /etc/apt/sources.list.d/dotnetdev.list'

sudo apt-get update
sudo apt-get build-essential zlib1g-dev libffi-dev libssl-dev libbz2-dev libreadline-dev libsqlite3-dev liblzma-dev python-tk python3-tk -y
sudo apt-get install azure-functions-core-tools-4 -Y

curl -fsSL https://aka.ms/install-azd.sh | bash