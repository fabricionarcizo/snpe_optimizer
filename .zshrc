# Environmental aliases.
# $ sudo apt install nano
# $ echo 'include "/usr/share/nano/*.nanorc"' >> ~/.nanorc
alias nano="/usr/bin/nano --tabstospaces --linenumbers"

# Path to your oh-my-zsh installation.
export ZSH=/root/.oh-my-zsh

# Miniforge setup.
export PYTHONPATH=$PYTHONPATH:/root/.miniforge3/
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$PYTHONPATH/lib/

# Set name of the theme to load. Optionally, if you set this to "random"
# it'll load a random theme each time that oh-my-zsh is loaded.
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
# $ git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k"
ZSH_THEME="powerlevel10k/powerlevel10k"

# Powerlevel9k customization.
DEFAULT_USER=$(whoami)
POWERLEVEL9K_MODE="nerdfont-fontconfig"
POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(os_icon context dir vcs anaconda)
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(status root_indicator background_jobs history time)
POWERLEVEL9K_PROMPT_ON_NEWLINE=true
POWERLEVEL9K_MULTILINE_LAST_PROMPT_PREFIX="▶️  "
POWERLEVEL9K_MULTILINE_FIRST_PROMPT_PREFIX=""
POWERLEVEL9K_ANACONDA_BACKGROUND=094

# ZSH Completion setup.
# $ git clone https://github.com/zsh-users/zsh-completions ${ZSH_CUSTOM:-${ZSH:-~/.oh-my-zsh}/custom}/plugins/zsh-completions
fpath+=${ZSH_CUSTOM:-${ZSH:-~/.oh-my-zsh}/custom}/plugins/zsh-completions/src
autoload -U compinit && compinit
source "$ZSH/oh-my-zsh.sh"

# ZSH Syntax Highlighting
# $ git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

# ZSH Auto Suggestions
# $ git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

# Autoenv: Directory-based Environments
# wget --show-progress -o /dev/null -O- 'https://raw.githubusercontent.com/hyperupcall/autoenv/main/scripts/install.sh' | sh
source ~/.autoenv/activate.sh

# Uncomment the following line to enable command auto-correction.
ENABLE_CORRECTION="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
HIST_STAMPS="dd/mm/yyyy"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
    1password
    aliases
    alias-finder
    autoenv
    autojump
    autopep8
    aws
    azure
    battery
    bazel
    branch
    brew
    colored-man-pages
    colorize
    conda
    conda-env
    copybuffer
    copyfile
    copypath
    cp
    docker
    docker-compose
    dotenv
    emoji
    emoji-clock
    encode64
    git
    git-auto-fetch
    git-commit
    git-escape-magic
    git-extras
    gitfast
    git-flow
    git-flow-avh
    github
    git-hubflow
    gitignore
    git-lfs
    git-prompt
    gnu-utils
    gradle
    history
    history-substring-search
    jsontools
    keychain
    macos
    macports
    nanoc
    nmap
    node
    nodenv
    npm
    nvm
    pep8
    pip
    pipenv
    poetry
    poetry-env
    pre-commit
    pyenv
    pylint
    python
    repo
    ssh
    sudo
    ubuntu
    vscode
    xcode
    zsh-autosuggestions
    zsh-interactive-cd
    zsh-navigation-tools
    zsh-syntax-highlighting
)

# Load Oh My Zsh config file.
source $ZSH/oh-my-zsh.sh

# User configuration

# Manpath.
export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment.
export LANG=en_US.UTF-8

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
alias zshconfig="sublime ~/.zshrc"
alias ohmyzsh="sublime ~/.oh-my-zsh"

# Plugins config.
export ZSH_COLORIZE_TOOL=pygmentize
export ZSH_COLORIZE_CHROMA_FORMATTER=terminal256
export ZSH_COLORIZE_STYLE="monokai"

# Preferred editor for local and remote sessions.
export EDITOR="nano"

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/root/.miniforge3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/root/.miniforge3/etc/profile.d/conda.sh" ]; then
        . "/root/.miniforge3/etc/profile.d/conda.sh"
    else
        export PATH="/root/.miniforge3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

# >>> mamba initialize >>>
# !! Contents within this block are managed by 'mamba shell init' !!
export MAMBA_EXE='/root/.miniforge3/bin/mamba';
export MAMBA_ROOT_PREFIX='/root/.miniforge3';
__mamba_setup="$("$MAMBA_EXE" shell hook --shell zsh --root-prefix "$MAMBA_ROOT_PREFIX" 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__mamba_setup"
else
    alias mamba="$MAMBA_EXE"  # Fallback on help from mamba activate
fi
unset __mamba_setup
# <<< mamba initialize <<<

# Change the OS Icon.
POWERLEVEL9K_OS_ICON_CONTENT_EXPANSION=%B$'\uF308'

# Define the terminal color.
export TERM=xterm-256color
