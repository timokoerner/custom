#!/bin/zsh

ad2(){
adb push "$1" storage/sdcard/
}


bold=`tput bold`
normal=`tput sgr0`

prodn=192.168.188 ;
ip=`ip addr show wlan0 | grep -Po 'inet \K[\d.]+'`
ipbas=$(echo $ip | cut -d . -f -3)
lsb=`lsb_release -i|cut -d: -f2|sed -e 's/^[[:blank:]]*//'`
#echo $lsb

te2(){
	echo $lsb
	echo $ip
}

he2(){

  echo "${bold}Argumente${normal} für $1:"
  for var in ${@:2} ; do
  echo $var
  done
}

function g(){
	geany $1 &
}

function he(){
	$1 --help
}


function in(){
	#if [ -z "$1" ]; then
	  #he2 `basename $0` "Paket"
	  #return
	#fi

  echo "${bold}Os: $lsb${normal}"
df -h
	if [ $lsb == 'ubuntu' ] ;then
	#if [ 1==1 ] ;then
echo "Ubuntu"
		apt-get install -y $1
	else
echo "Arch"
		pacman -S --noconfirm $1
fi
df -h
}

function ki(){
if [ -z "$1" ]; then
  he2 `basename $0` "Prozess für killall"
  return
fi
	killall $1;
	ps -ef|grep $1;
	echo "Prozess \$1 vernichtet"
}
	
function las(){

if [ -z "$1" ]; then
  he2 `basename $0` "Lautstärke amixer"
  return
fi

amixer set PCM $(expr $1 \* 10)%;
echo "Lautspr.: Argument \$1 mit 10 multipliziert."
}

# login remote shell
function lss(){
if [ -z "$1" ]; then
  he2 `basename $0` "letztes Oktett von ip " "opt. port"
  return
fi

        ssh $2 $ipbas.$1 
}

function mup(){
if [ -z "$1" ]; then
  he2 `basename $0` "Datei"
  return
fi
	mupdf $1 &
}

function mp(){
if [ -z "$1" ]; then
  he2 `basename $0` "Zeit"
  return
fi

	sleep $1;killall mplayer
	echo "wieder aufgewacht nach \$1"
}


function pr(){
if [ -z "$1" ]; then
  he2 `basename $0` "grep mit 'prozess substitution'" "Prozess"
  return
  
fi
	grep $1 =(ps aux)
}

function sc2(){
if [ -z "$1" ]; then
  he2 `basename $0` Datei "letztes Oktett" Zielordner "(port)"
  return
fi

	scp -P $4 -r $1  $ipbas.$2:$3 ;
}

function sho(){
	if [ $lsb -eq 'ubuntu' ] ;then
apt-cache show $1
	else
		pacman -Ss $1
fi	
}

function u(){
	
apt-get upgrade	
pacman -Syu
	
}

function ve(){
$1 --version
}

function yt(){
if [ -z "$1" ]; then
  he2 `basename $0` Youtube-Datei
  return
fi	

youtube-dl -x --audio-format mp3 --audio-quality 0 -o "%(title)s.)s" "$1" ;
}

 
function mov(){
	ver='/home/t/';
	root="/root/$1"
	#ver='.'
	ls -t $ver
	mv "$ver`ls -t $ver  | head -n1`" $1
	ls $1
 }

 
# alias
alias a='alias|le|gr'
alias ua='unalias'


#cd's
alias da="cd /root/django"
alias mu="cd /root/musik"
alias oh='cd /root/.oh-my-zsh'
alias oc='cd /root/.oh-my-zsh/custom'
alias vr='cd /root/vr'

#curl
alias cu='curl'
alias cl1='cu localhost:8000'


#Dateiops
alias d="rm -r"
alias md="mkdir -p"
alias to='touch'

#Dateisystem
alias pt='parted'
alias mn='mount'
alias um='umount'


# Energie
alias hi='hibernate'
alias h='hi'
alias rs='reboot'
alias s='pm-suspend'

#expect
alias ee='et expect1'
alias et='expect'
alias r=sr
alias sr='expect /root/.oh-my-zsh/custom/login_rp'
alias src='c /root/.oh-my-zsh/custom/login_rp'
alias srg='g /root/.oh-my-zsh/custom/login_rp'
alias srv='v /root/.oh-my-zsh/custom/login_rp'


# Hilfe
alias hc='c /root/.oh-my-zsh/custom/help.zsh'
alias hg='g /root/.oh-my-zsh/custom/help.zsh'
alias hl='le /root/.oh-my-zsh/custom/help.zsh|gr'
alias hs='so /root/.oh-my-zsh/custom/help.zsh'
alias hv='v /root/.oh-my-zsh/custom/help.zsh' 

# ls
alias l='ls -CF'
alias la='ls -A'
alias ld='ls -t $ver'
alias lh="ls --help"
alias li='ls -cl --group-directories-first'
alias lm="ls -l | more"
alias ll='ls -alF --full-time'
alias lsh="ls -halt --full-time"


# netzwerk
alias i=if
alias idu='ifdown wlan0;ifup wlan0'
alias ie='iwgetid -r'
alias ie2='iwconfig 2>&1 | grep ESSID'
alias if="ifconfig" 
alias ip2="echo $ip"
alias iu='ifup wlan0'
alias iw='iwlist wlan0 scan'
alias nm="nmap -sP $(echo $ipbas).1/24"
alias pi="ping google.de -c4" 


# package mgt.
alias ag='apt-get'
alias ar='ag remove -y'
alias aur='ag autoremove'
alias pm2="pacman -S"
alias pre='pacman -R --noconfirm'
alias up='ag update'


#programme
alias ab='abiword'
alias c='cat'
alias ec="export SWT_GTK3=0;/root/progr/eclipse/eclipse &"
alias le='less'
alias li='links2'
alias v="vim"


# ps
alias ba="bash"
alias k="kill -9"
alias kf=kfe
alias km="pmp;echo '\n';ki mplayer;echo '\n';pmp"
alias p="ps"
alias pfe='pr fetchmail'
alias pr2='ps -ef|grep'
alias psl="pr sleep"
alias pmp="pr mplayer"
alias pts="ps -ef|gr pts/"
alias psp="ps -p"
alias sl="sleep"

# Radio
alias ml="mplayer "

alias b="ml http://80.237.154.83:8120" # landsberg int.
alias cur="ml -playlist http://minnesota.publicradio.org/tools/play/streams/the_current.pls"
alias fm4="ml http://mp3stream1.apasf.apa.at:8000/" #fm4 orf
alias kl="ml -playlist http://minnesota.publicradio.org/tools/play/streams/classical.pls"
alias mpr="ml -playlist http://minnesota.publicradio.org/tools/play/streams/news.pls"
alias oe="ml http://194.232.200.156:8000" #oe3

#user
alias sur="sudo -i"
alias us="echo $USER"


alias ad='echo t@tk1.it|cli'
alias ad2='echo 015739598220 timo.koerner@hof-university.de dkoerner@konzertagentur-koerner.de'
alias cl='xclip -sel clip'
alias cp='cp -r'
alias dat='date'
alias df='df -h'
alias du='du -h'
alias e="exec zsh"
alias ex="exit"
alias f="find / -name"
alias f2="find -name"
alias gr='grep'
alias ha='halt'
alias hn='echo $(hostname)'
alias iban='DE63721500000050524271'
alias lag='amixer get PCM'
alias lsb="echo $lsb"
alias m='man'
alias mkdir='mkdir -p'
alias mt='mutt'
alias prp='pgrep'
alias r=sr
alias sr='expect /root/.oh-my-zsh/custom/login_rp'
alias srg='g /root/.oh-my-zsh/custom/login_rp'
alias st='stty -a'
alias t='wget --output-document=/dev/null http://speedtest.wdc01.softlayer.com/downloads/test500.zip'
alias ta='tail'
alias tar='tar xfvz'
alias te='terminator &'
alias tp='top'
alias tr='tree'
alias un='unzip'
alias w="dict -d fd-eng-deu"
alias w2="dict"
alias wp='chmod 777 -R .'
alias x='man'
alias z='gpicview'
alias zg='g /root/.zshrc'

echo "$0 aktualisiert von $$"
