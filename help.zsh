#!/bin/zsh

alias osp='git clone ssh://583d51142d527182db000116@p-tjava.rhcloud.com/~/git/p.git/'

custom=~/.oh-my-zsh/custom
hilfedatei=$custom/help.zsh
login_rp=$custom/login_rp
ifdd='ifdown'

bold=`tput bold`
normal=`tput sgr0`

os=$(expr substr $(uname -s) 1 9)

if [ $os != "CYGWIN_NT" ]; then
ip=`ip addr show wlan0 | grep -Po 'inet \K[\d.]+'`
ipbas=$(echo $ip | cut -d . -f -3)
lsb=`lsb_release -i|cut -d: -f2|sed -e 's/^[[:blank:]]*//'`
alias mt='mutt'
else
bi=$(wmic OS get OSArchitecture)
bi2=$(set | findstr ARCH)
echo 2
#alias bi2=$bi2
fi

te2(){
sleep 10&; kill $!
}

he2(){
#  echo "${bold}Os: $lsb${normal}"
	echo "\n${bold}Hilfe, os: $os"
	schleife=3
  if [[ $2 != argsleer ]] ;then
	  echo "Argumente für $1:"
	  schleife=2
  fi
  echo "${normal}"
  
  for var in ${@:$schleife} ; do
	echo $var
  done
  echo
}

function g(){
	geany $1 &
}

i(){
	
	if [ $os = "Linux" ]; then;ifconfig;else;ipconfig;fi
	
}


function in(){
	if [ -z "$1" ]; then
	he2 `basename $0` "Paket"
	return
	fi

	df -h
	if [[ $os = "Linux" ]] ;then
		if [[ $lsb = 'Arch' ]]; then
			echo "Arch"
			pacman -S --noconfirm $1
		else
			echo "Ubuntu"
			apt-get install -y $1
		fi
	else
		apt-cyg install $1
	fi

	df -h
}

ifda(){
	ip link set $1 down
}

ipu(){
		
	if [ -z "$1" ]; then
	he2 `basename $0` "Interface"
	return
	fi
	if [[ $lsb = 'Arch' ]]; then;ip link set $1 up;else;ifup $1;fi

}

function iu(){
	
	if [ -z "$1" ]; then
	he2 `basename $0` "Interface"
	return
	fi
	
	if [[ $os = "Linux" ]] ;then
	if [[ $lsb = 'Arch' ]]; then;ifda $1;ipu;else;$ifdd $1;ipu;fi
else;echo "Kein Linux";fi

#i
}

function k(){
if [ -z "$1" ]; then
  he2 `basename $0` "Prozess für kill"
  return
fi

if [ $os = 'Linux' ];then
kill -9 $1
else
/bin/kill.exe $1
fi

if [ -z "grep $1 =(ps aux)" ];then
echo Prozess gekillt
fi

}

function ki(){
if [ -z "$1" ]; then
  he2 `basename $0` "Prozess für killall"
  return
fi
	killall $1;
	ps -ef|grep $1;
}
	
function las(){

if [ -z "$1" ]; then
  he2 `basename $0` "Lautstärke amixer mit 10  	multipliziert"
  return
fi

amixer set PCM $(expr $1 \* 10)%;
}

# login remote shell
function lss(){
if [ -z "$1" ]; then
  he2 `basename $0` "letztes Oktett von ip " "opt. port"
  return
fi

        ssh $2 $ipbas.$1 
}


function mp(){
if [ -z "$1" ]; then
  he2 `basename $0` "Zeit"
  return
fi

	sleep $1;killall mplayer
}

function mup(){
if [ -z "$1" ]; then
  he2 `basename $0` "Datei"
  return
fi
	mupdf $1 &
}



function pl(){
if [ "$1" = -h ]; then
  he2 `basename $0` "argsleer" "Installierte Pakete zeigen, nur Linux"
  return
  
fi

if [[ $os = "Linux" ]] ;then

if [[ $lsb = 'Arch' ]]; then
pacman -Qeq |less
else
dpkg -l	|less
fi
fi
}

function pr(){
if [ -z "$1" ]; then
  he2 `basename $0` "grep mit 'prozess Substitution'" "Prozess"
  return
  
fi
	grep $1 =(ps aux)
}

function re(){
  echo "${bold}Os: $lsb${normal}"

if [ -z "$1" ]; then
  he2 `basename $0` "Löschen!" "Paket"
  return
  
fi

if [ $os = "CYGWIN_NT" ]; then;apt-cyg remove $1;else
if [[ $lsb == 'Arch' ]] ;then;pacman -R --noconfirm $1
	else;apt-get autoremove $1;fi
fi; 
}

function sc2(){
if [ -z "$1" ]; then
  he2 `basename $0` Datei "letztes Oktett" Zielordner "(port)"
  return
fi
#echo a2 $3
	scp  $1 $ipbas.$2:$3 
}


function schieb(){
	if [[ $os = "Linux" ]] ;then
		ver='/home/t/Downloads/';
	else
		ver='/cygdrive/c/Users/tk/Downloads/'
	fi

	if [ -z "$1" ]; then
	  he2 `basename $0` "Ziel"
	  return
	fi
	
	ziel=$1
	if [ $1 = 'r' ];then
		ziel='/root'
	fi
	
	ls -t $ver
	mv "$ver`ls -t $ver | head -n1`" $ziel
	echo Inhalt von $ziel
	ls $ziel
}


function sho(){

if [ -z "$1" ]; then
  he2 `basename $0` "Paket"
  return
fi

if [ $os = "CYGWIN_NT" ]; then
apt-cyg show `echo $1`;else ;if [[ $lsb == 'Arch' ]] ;then;pacman -Ss $1 ;else;apt-cache show $1 ;fi;fi;
}

t(){
	
	wget http://speedtest.wdc01.softlayer.com/downloads/test500.zip `if [ $os = "Linux" ]; then ; echo --output-document=/dev/null;fi`
}

function u(){
if [ "$1" = -h ]; then
  he2 `basename $0` "argsleer" "Upgrade machen"
  return
  
fi	

if [[ $lsb == 'Arch' ]] ;then
		pacman -Syu
	else
apt-get upgrade	
fi	
}

 
# alias
alias aa='wget http://speedtest.wdc01.softlayer.com/downloads/test500.zip `if [ $os = "Linux" ]; then ; echo --output-document=/dev/null
fi`'
alias a='alias|le|gr'
alias am='alias -m'
alias ua='unalias'

# betriebssystem
alias lsb="echo $lsb"
alias os="echo $os"
alias pa='echo $path'


#cd's
alias da="cd ~/django"
alias mu="cd ~/musik"
alias o='cd ~/.oh-my-zsh/custom'
alias oh='cd ~/.oh-my-zsh'
alias pd='cd ~/git/p'

#curl
alias cu='curl'
alias cl1='cu localhost'
alias cl2='cu localhost:8000'


#Dateiops
alias d="rm -rf"
alias md="mkdir -p"
alias mo="chmod 700"
alias to='touch'

#Dateisystem
alias pt='parted'
alias mn='mount'
alias um='umount'

#Dict
alias wl="echo Dict.;dict -D"
alias w="dict -d fd-eng-deu"
alias w2="dict"


# Editoren
alias ab='abiword'
alias n='notepad++'
alias v="vim"


# Energie
alias hi='hibernate'
alias rest='reboot'
alias s='pm-suspend'

#expect
alias et='expect'
alias r=sr
alias sr='expect ~/.oh-my-zsh/custom/login_rp'
alias src="c $custom/login_rp"
alias srv="v $custom/login_rp"


# Hilfe
alias -g h="--help"
alias -g hd="$hilfedatei"
alias hl="le $hilfedatei"
alias hn="n $hilfedatei"

# Konsole
alias she='echo $0'
alias st='stty -a'
alias tt='temp=$(tty) ; echo ${temp:5}'


# netzwerk

alias ie='iwgetid -r'
alias ie2='iwconfig 2>&1 | grep ESSID'
alias ip2="echo $ip"
alias ifdd="$ifdd"
alias ifda="$ifda"
alias iw='iwlist wlan0 scan|gr'
alias nm="nmap -sP $(echo $ipbas).1/24"
alias pi="ping google.de `if [ $os = CYGWIN_NT ]; then
 echo -n 4;else;echo -c4;fi`"


# package mgt.
alias acl='apt-cyg listall'
alias acl2='cygcheck'
alias ag='apt-get'
alias pm2="pacman -S"
alias up='ag update'


# ps
alias ba="bash"
alias pr2='ps -ef|grep'
alias psl="pr sleep"
alias pmp="pr mplayer"
alias pts="ps -ef|gr pts/"
alias psp="ps -p"
alias sl="sleep"
alias wh="who"

# Radio
alias ml="mplayer "

alias b="ml http://80.237.156.8:8120" # landsberg int.
alias cur="ml -playlist http://minnesota.publicradio.org/tools/play/streams/the_current.pls"
alias fm4="ml http://mp3stream1.apasf.apa.at:8000/" #fm4 orf
alias kl="ml -playlist http://minnesota.publicradio.org/tools/play/streams/classical.pls"
alias mpr="ml -playlist http://minnesota.publicradio.org/tools/play/streams/news.pls"
alias oe="ml http://194.232.200.156:8000" #oe3

#rhc
alias rha='rhc app-restart'
alias rhs='rhc ssh'


#user
alias sur="sudo -i"
alias us="echo $USER"


alias ad='echo t@tk1.it|cli'
alias ad2='echo 015739598220 timo.koerner@hof-university.de dkoerner@konzertagentur-koerner.de'
alias c='cat'
alias le='less'
alias cl='xclip -sel clip'
alias cp='cp -r'
alias dt='date'
alias dc='declare -f'
alias dh='df -h'
alias du='du -h'
alias e="exec zsh"
alias ecl="export SWT_GTK3=0;~/progr/eclipse/eclipse &"
alias ec="echo"
alias ex="exit"
alias f="find / -name"
alias f2="find -name"
alias gr='grep'
alias ha='halt'
alias ho='echo $(hostname)'
alias iban='DE637215 0000 00 5052 4271'
alias lag='amixer get PCM'
alias li='links2'
alias lsh="ls -halt --full-time"
alias m='man'
alias mb='m bash'
alias msd='mysql -uroot d'
alias ms='mysql -uroot d -e "select*from app1_$1"'
alias msd='mysql -uroot d -e "describe app1_$1"'
alias mss='mysql -uroot d -e "show tables"'
alias mkdir='mkdir -p'
alias p1='echo $1'
alias prp='pgrep'
alias r=sr
alias so="source"
alias sr="expect $login_rp"
alias srg="g $login_rp"
alias ta='tail'
alias te='if [ $os != "CYGWIN_NT" ]; then;terminator &;else; mintty;fi'
alias tp='top'
alias tr='tree'
alias -g ve="--version"
alias wp='chmod 777 -R .'
alias yt='youtube-dl -x --audio-format mp3 --audio-quality 0 -o "%(title)s.)s"'
alias zg='g ~/.zshrc'

echo "$0 aktualisiert von $$"
