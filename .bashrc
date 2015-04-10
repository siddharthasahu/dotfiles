
# Replace with a tmux session if it is an interactive session and tmux is installed and is not already running
if [[ $UID -ne 0 ]] && [[ $- = *i* ]] && which tmux > /dev/null 2>&1 && [[ -z "$TMUX" ]] && [[ ! $TTY = *tty* ]] ;then
    ID="`tmux ls | grep -vm1 attached | cut -d: -f1`" # get the id of a deattached session
    if [[ -z "$ID" ]] ;then # if not available create a new one
        exec tmux new-session
    else
        exec tmux attach-session -t "$ID" # if available attach to it
    fi
fi

export LANG='en_US.UTF-8'
export EDITOR='vim'
export PATH="/sbin:/usr/sbin::$PATH"

MYSHELL=$(ps -p $$ -ocomm= 2>/dev/null)

if [[ $- = *i* ]] && [[ "$MYSHELL" = 'bash' ]];then
    bind '"\e[A": history-search-backward'
    bind '"\e[B": history-search-forward'

    shopt -s nocaseglob;                    # Case-insensitive globbing (used in pathname expansion)
    shopt -s histappend;                    # Append to the Bash history file, rather than overwriting it
    shopt -s cdspell;                       # Autocorrect typos in path names when using `cd`
fi

# Reset
Color_Off="\[\033[0m\]"       # Text Reset

# Regular Colors
Black="\[\033[0;30m\]"        # Black
Red="\[\033[0;31m\]"          # Red
Green="\[\033[0;32m\]"        # Green
Yellow="\[\033[0;33m\]"       # Yellow
Blue="\[\033[0;34m\]"         # Blue
Purple="\[\033[0;35m\]"       # Purple
Cyan="\[\033[0;36m\]"         # Cyan
White="\[\033[0;37m\]"        # White

# Bold
BBlack="\[\033[1;30m\]"       # Black
BRed="\[\033[1;31m\]"         # Red
BGreen="\[\033[1;32m\]"       # Green
BYellow="\[\033[1;33m\]"      # Yellow
BBlue="\[\033[1;34m\]"        # Blue
BPurple="\[\033[1;35m\]"      # Purple
BCyan="\[\033[1;36m\]"        # Cyan
BWhite="\[\033[1;37m\]"       # White

[[ $UID -eq 0 ]] && color=${BRed} || color=${BPurple}
[[ $UID -eq 0 ]] && prompt='#' || prompt='$'
export PS1="\n[${BBlue}${MYSHELL}${Color_Off}:${color}\u@\H${Color_Off}] ${BGreen}\w\n`if [ $? = 0 ]; then echo "${BGreen}"; else echo "${BRed}"; fi`${prompt}${Color_Off} "

alias ..='cd ..'
alias ...='cd ../..'
alias b='cd -'
alias ls='sudo ls -CFh --color=auto'
alias lsa='sudo ls -aCFh --color=auto'
alias lst='sudo ls -aCFhrt --color=auto'
alias ll='sudo ls -CFlh --color=auto'
alias lla='sudo ls -aCFlh --color=auto'
alias llt='sudo ls -aCFlhrt --color=auto'
alias lsg='sudo ls -aCFlh --color=auto | grep --color=auto -i'
alias psg='sudo ps aux | grep -v grep | grep -i -e VSZ -e '
alias psgc='sudo ps aux | grep -v grep | grep -i -e '
alias pkl='sudo kill -9'
alias lsofs='sudo lsof | grep'
alias ports='sudo netstat -tulanp | grep LISTEN'
alias portsa='sudo netstat -tulanp'
alias mkdir="mkdir -p"
alias smkdir="sudo mkdir -p"
alias rr='sudo rm -rf'
alias mount='sudo mount -v'
alias umount='sudo umount -v'
alias pu='pushd'
alias cat='sudo cat'
alias po='popd'
alias dmesg='sudo dmesg --human -T'
alias gitk='gitk --all'
alias grep='sudo grep -i --color=auto'
alias crns='sudo crontab -l'
alias crne='sudo crontab -e'
alias crnsu='sudo crontab -l -u'
alias tf='sudo tail -f'
alias vi='vim'
alias s='ssh'
alias se='sudoedit'
alias sv='sudo vim -u ~/.vimrc'
alias e='vim'
alias tarc="tar czf"
alias tarx="tar xzf"
alias starc="sudo tar czf"
alias starx="sudo tar xzf"
alias myips='ip -o -f inet addr | grep -v "127.0.0.1" | cut -d"/" -f1 | cut -d" " -f2- | sort | uniq | awk "{print \$1\": \"\$3}"'
alias dateh='date --help|sed -n "/^ *%%/,/^ *%Z/p"|while read l;do F=${l/% */}; date +%$F:"|'"'"'${F//%n/ }'"'"'|${l#* }";done|sed "s/\ *|\ */|/g" |column -s "|" -t'
alias jlog='sudo journalctl -n500 -f'

alias please='sudo "$BASH" -c "$(history -p !!)"'

alias rzsh='. ~/.bashrc && . ~/.zshrc'
alias rbash='. ~/.bashrc'

alias gita='git add'
alias gitc='git commit -m'
alias gitca='git commit -am'
alias gits='git status'
alias gitt='git stash'
alias gittp='git stash pop'
alias gitl='git ls'
alias gitcl='git clone'
alias gitb='git branch -a'
alias gitpu='git push'
alias gitp='git pull'
alias gpgp='git pull --rebase && git push'

alias dk='sudo docker'
alias dkr='sudo docker run'
alias dki='sudo docker images'
alias dkia='sudo docker images -a'
alias dkc='sudo docker ps'
alias dkca='sudo docker ps -a'
dkrc() { sudo docker start $1 && sudo docker attach $1;}

# Pacman package management
alias pcmu='sudo pacman -Syu'
alias pcmi='sudo pacman -S'
alias pcms='sudo pacman -Ss'
alias pcmsl='sudo pacman -Qs'
alias pcmr='sudo pacman -Rc'
alias pcmc='sudo pacman -Sc --noconfirm'

# Apt-get package management
alias agu='sudo apt-get update && sudo apt-get upgrade'
alias agi='sudo apt-get install'
alias ags='sudo apt-cache search'
alias agr='sudo apt-get remove'

# Yum package management
alias yumu='sudo yum update'
alias yumi='sudo yum install'
alias yums='sudo yum search'
alias yumr='sudo yum remove'

alias jetpistol='sudo puppet agent -tv'
alias magic='sudo openvpn --config ~/directi/client.ovpn'

alias ccm='sudo ccm64'
alias xcdwebfol='cd /srv/www'
alias xcddev='cd /home/sdh/dev'
alias xcdactive='cd /home/sdh/dev/sources/telepathy-kde-active/ktp-active/application/package'
alias xchromestart="chromium --proxy-server='socks://127.0.0.1:9999' --incognito"
alias xstartproxy="ssh -TNfD 9999 root@5.175.167.132"
alias xstartproxy2="ssh -TNfD '*:9999' -p 9999 dcadmin@172.16.32.222"

# Systemd service management
sds() { sudo systemctl status -l $1.service; }
sdst() { sudo systemctl start $1.service ; sudo systemctl status -l $1.service; }
sdsp() { sudo systemctl stop $1.service ; sudo systemctl status -l $1.service; }
sdr() { sudo systemctl restart $1.service ; sudo systemctl status -l $1.service; }
sdrl() { sudo systemctl reload $1.service; }
sde() { sudo systemctl enable $1.service ; ls -l /etc/systemd/system/multi-user.target.wants; }
sdd() { sudo systemctl disable $1.service ; ls -l /etc/systemd/system/multi-user.target.wants; }

# Init scripts service management
ups() { sudo service $1 status ; }
upst() { sudo service $1 start ; }
upsp() { sudo service $1 stop ; }
upr() { sudo service $1 restart ; }
uprl() { sudo service $1 reload ; }
upe() { sudo chkconfig --add $1 && sudo chkconfig $1 on && sudo chkconfig --list $1 ; }
upd() { sudo chkconfig $1 off && sudo chkconfig --list $1 ; }

mkcd() {
    mkdir -p $1 && cd $1
}

xs() {
    if [ $# -lt 1 ]; then
        echo "No input!"
        return 1
    fi

    sudo grep --color=auto -Rn $* *
}

xf() {
    if [ $# -lt 1 ]; then
        echo "No input!"
        return 1
    fi

    sudo find -name "*$**"
}

h() { if [ -z "$*" ]; then history 1; else history 1 | egrep "$@"; fi; }

up() {
    if [ -z "$*" ]; then 1='1';fi
    pd=`pwd`
    cd $(eval printf '../'%.0s {1..$1}) && echo "${pd} -> $(pwd)";
}

fawk() {
    first="awk '{print "
    last="}'"
    cmd="${first}\$${1}${last}"
    eval $cmd
}

gitkf() {
  gitk_follow () {
    while (( "$#" )); do
      git log -p --oneline --name-status --follow $1;
      shift;
    done | perl -ne 'if( s{^(?:[ACDMRTUXB]|R\d+)\s+}{} ) { s{\s+}{\n}g; print; }' | sort -u
  }
  gitk $(gitk_follow $*)
}

man() {
    env LESS_TERMCAP_mb=$'\E[01;31m' \
    LESS_TERMCAP_md=$'\E[01;38;5;74m' \
    LESS_TERMCAP_me=$'\E[0m' \
    LESS_TERMCAP_se=$'\E[0m' \
    LESS_TERMCAP_so=$'\E[38;5;246m' \
    LESS_TERMCAP_ue=$'\E[0m' \
    LESS_TERMCAP_us=$'\E[04;38;5;146m' \
    man "$@"
}

changehostname() {
    if [ $# -lt 2 ]; then
        echo "Usage: changehostname centos|ubuntu hostname"
        return 1
    fi
    os="$1"
    nhostname="$2"

    case "$os" in
    centos)
        [[ -r '/etc/sysconfig/network' ]] && sudo sed -i "/HOSTNAME/ s/^.*$/HOSTNAME=${nhostname}/" /etc/sysconfig/network || { echo "File not found"; return -1; }
        ;;
    ubuntu)
        [[ -r '/etc/hostname' ]] && echo $nhostname | sudo tee /etc/hostname > /dev/null
        ;;
    *) echo "No match!"
        ;;
    esac
    sudo hostname "$nhostname"
    [[ -r '/etc/hosts' ]] && grep -v "$nhostname" /etc/hosts > /dev/null || sudo sed -i "/127.0.0.1/ s/$/ $nhostname/" /etc/hosts
}

xdeletefromgit() {
    if [ $# -eq 0 ]; then
        return 0
    fi

    # make sure we're at the root of git repo
    if [ ! -d .git ]; then
        echo "Error: must run this script from the root of a git repository"
        exit 1
    fi

    # remove all paths passed as arguments from the history of the repo
    files=$@
    git filter-branch --index-filter "git rm -rf --cached --ignore-unmatch $files" HEAD

    # remove the temporary history git-filter-branch otherwise leaves behind for a long time
    rm -rf .git/refs/original/ && git reflog expire --all &&  git gc --aggressive --prune
}

xreauthorgit() {
    if [ $# -lt 3 ]; then
        return 0
    fi

git filter-branch --env-filter '
 
OLD_EMAIL="'"$1"'"
CORRECT_NAME="'"$2"'"
CORRECT_EMAIL="'"$3"'"
 
if [ "$GIT_COMMITTER_EMAIL" = "$OLD_EMAIL" ]
then
export GIT_COMMITTER_NAME="$CORRECT_NAME"
export GIT_COMMITTER_EMAIL="$CORRECT_EMAIL"
fi
if [ "$GIT_AUTHOR_EMAIL" = "$OLD_EMAIL" ]
then
export GIT_AUTHOR_NAME="$CORRECT_NAME"
export GIT_AUTHOR_EMAIL="$CORRECT_EMAIL"
fi
' --tag-name-filter cat -- --branches --tags
}

xextract() {
    if [[ -f "$1" ]]; then
        case "$1" in
            *.lrz) lrztar -d "$1" ;;
            *.tar.bz2) tar xjf "$1";;
            *.tar.gz) tar xzf "$1" ;;
            *.tar.xz) tar Jxf "$1" ;;
            *.bz2) bunzip2 "$1";;
            *.rar) rar x "$1";;
            *.gz) gunzip "$1"  ;;
            *.tar) tar xf "$1"  ;;
            *.tbz2) tar xjf "$1" ;;
            *.tgz) tar xzf "$1" ;;
            *.zip) unzip "$1" ;;
            *.Z) uncompress "$1"  ;;
            *.7z) 7z x "$1" ;;
            *) echo "don't know how to extract '$1'..." ;;
        esac
    else
    echo "'$1' is not a valid file!"
    fi
}

xgitc() {
    if [ "$1" = "" ]; then
        mstatus="updates: $(date +'%Y-%m-%d %H:%M:%S')"
        printf "You've not set any message: '$mstatus' is being used [Y|n]: "
        read inp
        if [ "$inp" = "n" ]; then
            return 1
        fi
    else
        mstatus="$1"
    fi
    git add -A .
    git commit -a -m "$mstatus"
    if [ "$2" != "" ]; then
        git push -u origin master
    fi
}

xgiaction() {
    if [ $# -lt 1 ];then
        echo "Usage: xgiaction action [arguments]"
        return
    fi

    walkfolderandexecute() {
        pushd "$1" > /dev/null || return -1
        shift
        if [ -d ".git" ];then
            printf "\n********git $1 in $(pwd)********\n"
            git $*
        elif [ -d ".bzr" ];then
            if [ "$1" = "pull" ];then
                printf "\n********Updating bzr repo $(pwd)********\n"
                bzr update
            fi
        elif [ -d ".svn" ];then
            if [ "$1" = "pull" ];then
                printf "\n********Updating svn repo $(pwd)********\n"
                svn fetch
            fi
        else
            printf "\n********Entering $(pwd)********\n"
            for i in *;do
            if [ -d "$i" ];then
                walkfolderandexecute "$i" $*
            fi
            done
        fi
        popd > /dev/null || return -1
    }

    walkfolderandexecute "." $*
}

xuploadpicasa() {
    if [ $# -lt 1 ];then
        echo "Usage: xuploadpicasa albumname [nocreate]"
        return 1
    fi
    f="resized"
    n=$1
    mkdir -p "$f"
    for i in *;do
        echo $i
        [[ -f "$i" ]] && convert "$i" -resize "2048x2048>" "$f/$i"
    done
    cd "$f" && \
    [[ "$2" != "nocreate" ]] && google -v --access=private picasa create "$n" || echo "Reusing $1" && \
    google -v picasa post "$n" * && \
    cd ..
}

xuploadskydrive() {
    if [ $# -lt 2 ];then
        echo "Usage: xuploadskydrive local_file|local_folder remotefolder"
        return 1
    fi

    pd=$(pwd)

    control_c() {
        cd "$pd"
        return
    }

    walkfolderandupload() {
        trap control_c SIGINT

        if [ -d "$1" ];then
            printf "Entering directory '$1' using '$2'\n"
            pushd "$1" > /dev/null || return 1
            printf "Creating remote folder '$2/$(basename "$1")'\n"
            onedrive-cli $3 $4 $5 mkdir "$2/$(basename "$1")" &> /dev/null
            for i in *;do
                walkfolderandupload "$i" "$2/$(basename "$1")"  $3 $4 $5 || return 3
            done
            printf "Exiting directory '$1' using '$2'\n"
            popd > /dev/null || return 2
        elif [ -f "$1" ];then
            printf "Uploading file '$1' to '$2/'\n"
            onedrive-cli $3 $4 $5 put -n "$1" "$2" || return 0
        else
            echo "Unrecognized object '$1' in '$(pwd)'"
        fi
    }

    trap control_c SIGINT

    walkfolderandupload "$1" "$2" $3 $4 $5
    control_c
}

xmakecustomarchiso() {
    if [ $# -lt 1 ]; then
        echo "Need iso path and iso label!"
        return 1
    fi
    isoname=sdh-$(basename "$1")
    isolabel=$(isoinfo -d -i "$1" | grep "Volume id" | sed "s/Volume id: //")
    outputdir=$(pwd)
    sudo umount /tmp/sdh-customiso/mnt > /dev/null 2>&1
    rm -rf /tmp/sdh-customiso
    echo "Creating dirs..." && \
    mkdir -p /tmp/sdh-customiso/{,mnt,contents} && \
    cd /tmp/sdh-customiso && \
    echo "Mounting iso..." && \
    sudo mount -o loop "$1" /tmp/sdh-customiso/mnt/ && \
    echo "Extracting contents..." && \
    cp -a mnt/* contents && \
    cd contents && \
    echo "Copying scripts..." && \
    rsync --copy-links -vr /home/lfiles/dev/archlinux-install-scripts . && \
    chmod +x archlinux-install-scripts/* && \
    echo "Creating new iso '$isoname' to $outputdir..." && \
    genisoimage -r -V "$isolabel" -cache-inodes -J -l -b isolinux/isolinux.bin -c isolinux/boot.cat -no-emul-boot -boot-load-size 4 -boot-info-table -o /tmp/sdh-customiso/"$isoname" . && \
    mv /tmp/sdh-customiso/"$isoname" $outputdir
    echo "Cleaning up..."
    sudo umount /tmp/sdh-customiso/mnt
    #rm -rf /tmp/sdh-customiso
    cd $outputdir
    echo "Done."
}

xlistfiles() {
    case "$1" in
        hdd1) 1='/run/media/sdh/sdh-hdd1'
            flname=files-hdd1
            ;;
        hdd2) 1='/run/media/sdh/sdh-hdd2'
            flname=files-hdd2
            ;;
        *) 1='/xfiles'
            flname=files
            ;;
    esac

    find "$1" -type d \( -name ".git" -o -name ".hg" -o -name "Dev" -o -name "\$RECYCLE.BIN" -o -name "System Volume Information" -o -name "version-controlled-soft" -o -name "manuals" -o -name "eclipse" \) -prune -o -print | sort > ~/Downloads/${flname}.txt
}

xxown() {
    sudo chown -R $(whoami):http .
}

xintegration() {
    git stash && \
    git checkout master && \
    git pull && \
    for i in $(git branch | grep sdh);do
        git checkout "$i";
        git rebase master;
    done && \
    git checkout master && \
    git branch -D integration || true && \
    git checkout -b integration && \
    for i in $(git branch | grep sdh);do
        git merge "$i";
    done
}

xplaylist() {
    if [ $# -lt 1 ]; then
    echo "No input!"
    return 1
    fi

    cd $1

    if [ "$2" == "" ];then
    ext="mp4"
    else
    ext=$2
    fi

    for i in *; do
        if [ -d "$i" ];then
            echo $i
            printf "#EXTM3U\n" > $i.m3u
            for j in $(for k in $(ls $i/*\.$ext); do echo $k;done | sort -V); do
                printf "#EXTINF:-1,$j\n$j\n" >> $i.m3u
            done
        fi
    done
}

xkdechanges() {
    for i in *;do if [ -d "$i" -a -r "$i"/git-checkout-update.log ];then echo $i;cat "$i"/git-checkout-update.log; fi;done | grep -B4 commit | grep -e commit -e directory | while IFS= read -r line;do read -r line2; dr=$(echo $line | awk '{print $4}'); echo $dr; echo $line2 | grep commit; echo; cd "$dr"; gitk; cd - > /dev/null ;done
}

xpatternrename() {
    if [ $# -lt 2 ]; then
        echo "Please give two patterns!"
        return 1
    fi
    for i in *;do x=$(echo $i | sed "s|$1|$2|"); if [ ! -r "$x" ];then echo "$i->$x"; mv "$i" "$x";fi;done
}

xgpp() {
    if [ $# -lt 1 ]; then
    echo "No input files!"
    return 1

    elif [ $# -eq 2 ]; then
    g++ $1 && ./a.out < $2

    else
    g++ $1 && ./a.out
    fi

    rm -f a.out
}

xgcc() {
    if [ $# -lt 1 ]; then
    echo "No input files!"
    return 1

    elif [ $# -eq 2 ]; then
    gcc $1 && ./a.out < $2 && rm a.out

    else
    gcc $1 && ./a.out  && rm a.out
    fi
}

xccreatefolder() {
    if [ $# -ne 1 ]; then
    echo "Wrong input!"
    return 1
    fi

    mkdir -p $1 && ( echo '#include<stdio.h>
int main() {

    return 0;
}' > $1/$1.c ; touch $1/in$1.txt )
}

xcppcreatefolder() {
    if [ $# -ne 1 ]; then
    echo "Wrong input!"
    return 1
    fi

    mkdir -p $1 && ( echo '#include<iostream>
using namespace std;
int main() {

    return 0;
}' > $1/$1.cpp ; touch $1/in$1.txt )
}

xregexrename() {
  if [ $# -lt 1 ]; then
    echo "Wrong input!"
    return 1
  fi
  for i in *;do
    x=$(echo $i | sed "$1"); [[ ! -r "$x" ]] && echo "$i -> $x" && [[ "$2" = "m" ]] && mv "$i" "$x"
  done
}

xrenametotitlecase() {
    pd=$(pwd)
    if [ ! -z "$1" ];then
        pd="$1"
    fi
    pushd "$pd" > /dev/null && \
    for i in *;do x=$(echo $i | tr "[A-Z]" "[a-z]" | sed "s/\( \| \?-\| \?(\| \?\[\|^\)\(.\)/\1\u\2/g");[ ! -r "$x" ] && mv "$i" "$x";done && \
    popd > /dev/null
}

xrenametolowercase() {
    depth=0
    maxdepth=1
    rename() {
        if [ ! -z "$1" ];then
            echo "Inside directory: $1"
            pushd $1 > /dev/null
            for i in *;do
                    if [ -d "$i" ];then
                        if [ "$i" = "System Volume Information" -o "$i" = "\$RECYCLE.BIN" ];then
                            echo "Skipping $i"
                            continue
                        fi
                        dr=$i
                        x=$(echo $i|tr '[A-Z]' '[a-z]'|tr ' ' '-')
                        if [ ! -d "$x" ];then
                            echo "Dir - $i: ### Renaming to $x ###"
                            dr=$x
                            mv "$i" "$x"
                        elif [ "$x" != "$i" ];then
                            echo "Dir - $i: *** Not renamed: dir $x already exists ***"
                        else
                            echo "Dir - $i: OK"
                        fi
                        if test $depth -lt $maxdepth;then
                            echo $((depth++))
                            rename "$1/$dr"
                            echo $((depth--))
                        fi
                    fi
            done
            for i in *;do
                if [ -f "$i" ];then
                    x=$(echo $i|tr '[A-Z]' '[a-z]'|tr ' ' '-')
                    if [ ! -f "$x" ];then
                        echo "File - $i: ### Renaming to $x ###"
                        mv "$i" "$x"
                    elif [ "$x" != "$i" ];then
                        echo "File - $i: *** Not renamed: file $x already exists ***"
                    else
                        echo "File - $i: OK"
                    fi
                fi
            done
            echo "Leaving directory: $1"
            popd > /dev/null
        fi
    }
    pd=$(pwd)
    if [ ! -z "$1" ];then
    pd=$1
    fi
    if [ ! -z "$2" ] && [ "$2" = "-d" ]
        then
        if [ ! -z "$3" ];then
            maxdepth=$3
        fi
    fi
    rename "$pd"
}
