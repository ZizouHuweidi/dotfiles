alias vim="nvim"
alias vi="nvim"
alias v="nvim"
alias za="zathura"
alias visudo="sudo -E -s nvim"
alias ports="sudo netstat -tulpn | grep LISTEN"
alias cat="bat"
alias py="python"
alias k="kubectl"

#vim files shortcuts
alias npacman="sudo $EDITOR /etc/pacman.conf"
alias nmkinitcpio="sudo $EDITOR /etc/mkinitcpio.conf"
alias nmirrorlist="sudo $EDITOR /etc/pacman.d/mirrorlist"
alias narcomirrorlist='sudo $EDITOR /etc/pacman.d/arcolinux-mirrorlist'
alias nfstab="sudo $EDITOR /etc/fstab"
alias nnsswitch="sudo $EDITOR /etc/nsswitch.conf"
alias ngnupgconf="sudo $EDITOR /etc/pacman.d/gnupg/gpg.conf"

# navigation
alias ..='cd ..'
alias ...='cd ../..'
alias .3='cd ../../..'
alias .4='cd ../../../..'
alias .5='cd ../../../../..'

# Verbosity and settings that you pretty much just always are going to want.
alias cp="cp -iv"
alias mv="mv -iv"
alias rm="rm -vI"
alias bc="bc -ql"
alias mkd="mkdir -pv"
alias yt="yt-dlp --embed-metadata -i"
alias yta="yt -x -f bestaudio/best"
alias ffmpeg="ffmpeg -hide_banner"

# git
alias addup='git add -u'
alias addall='git add .'
alias branch='git branch'
alias checkout='git checkout'
alias clone='git clone'
alias commit='git commit -m'
alias fetch='git fetch'
alias pull='git pull origin'
alias push='git push origin'
alias tag='git tag'
alias newtag='git tag -a'
alias gt="nvim ~/.gittoken"

# #list
# alias ls='ls --color=auto'
# alias la='ls -a'
# alias ll='ls -la'
# alias l='ls'
# alias l.="ls -A | egrep '^\.'"

# Changing "ls" to "exa"
# alias ls='exa --color=always  --group-directories-first'
# alias la='exa -a --color=always  --group-directories-first'
# alias ll='exa -l --color=always  --group-directories-first'
# alias lt='exa -aT --color=always --group-directories-first'
# alias l.='exa -a | egrep "^\."'

# Changing "ls" to "lsd"
alias ls='lsd --color=always  --group-directories-first'
alias la='lsd -a --color=always  --group-directories-first'
alias ll='lsd -l --color=always  --group-directories-first'
alias lt='lsd -aT --color=always --group-directories-first'
alias l.='lsd -a | egrep "^\."'

#fix obvious typo's
# alias cd..='cd ..'
# alias pdw="pwd"
# alias udpate='sudo pacman -Syyu'
# alias upate='sudo pacman -Syyu'
# alias updte='sudo pacman -Syyu'
# alias updqte='sudo pacman -Syyu'
# alias upqll="paru -Syu --noconfirm"
# alias upal="paru -Syu --noconfirm"

## Colorize the grep command output for ease of use (good for log files)##
alias grep='grep --color=auto'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'

#readable output
alias df='df -h'

#free
alias free="free -mt"

#continue download
alias wget="wget -c"

#userlist
alias userlist="cut -d: -f1 /etc/passwd"

#ps
alias psa="ps auxf"
alias psgrep="ps aux | grep -v grep | grep -i -e VSZ -e"

#youtube download
alias yta-aac="yt-dlp --extract-audio --audio-format aac "
alias yta-best="yt-dlp --extract-audio --audio-format best "
alias yta-flac="yt-dlp --extract-audio --audio-format flac "
alias yta-mp3="yt-dlp --extract-audio --audio-format mp3 "
alias ytv-best="yt-dlp -f 'bestvideo[ext=mp4]+bestaudio[ext=m4a]/bestvideo+bestaudio' --merge-output-format mp4 "

#search content with ripgrep
alias rg="rg --sort path"

#get the error messages from journalctl
alias jctl="journalctl -p 3 -xb"

#gpg
#verify signature for isos
alias gpg-check="gpg2 --keyserver-options auto-key-retrieve --verify"
alias fix-gpg-check="gpg2 --keyserver-options auto-key-retrieve --verify"
#receive the key of a developer
alias gpg-retrieve="gpg2 --keyserver-options auto-key-retrieve --receive-keys"
alias fix-gpg-retrieve="gpg2 --keyserver-options auto-key-retrieve --receive-keys"
alias fix-keyserver="[ -d ~/.gnupg ] || mkdir ~/.gnupg ; cp /etc/pacman.d/gnupg/gpg.conf ~/.gnupg/ ; echo 'done'"

#systeminfo
alias probe="sudo -E hw-probe -all -upload"
alias sysfailed="systemctl list-units --failed"

#remove
alias rmgitcache="rm -r ~/.cache/git"

# the terminal rickroll
alias rr='curl -s -L https://raw.githubusercontent.com/keroserene/rickrollrc/master/roll.sh | bash'
