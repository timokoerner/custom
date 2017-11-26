# schriftfarbe autocomplete fg8 default
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=2'

idrs=~/.ssh/id_rsa.pub 
login_rp=$ZSH_CUSTOM/login_rp
zr=~/.zshrc
mediaDir='/media/t'
dow='Downloads'

bold=`tput bold`
normal=`tput sgr0`

os=`uname -a |cut -d' ' -f 1`


if [ $os != "CYGWIN_NT-6.1" ]; then
	homeT='/home/t'
	home='/root'
	com_alias=$ZSH_CUSTOM/plugins/common-aliases/common-aliases.plugin.zsh
	ggpl=$ZSH_CUSTOM/plugins/git/git.plugin.zsh
	pg=$ZSH_CUSTOM/plugins/python/python.plugin.zsh

	lsb=`lsb_release -i|cut -d: -f2|sed -e 's/^[[:blank:]]*//'`
	arc=`uname -a |cut -d' ' -f 14`
	dowDir=$homeT/Downloads
	mteDir=$home/git/mte
	pts=pts
	zr=~/.zshrc

else
	pts=pty
	lsb=cygwin
	home='/cygdrive/C/Users/itdlz-koer'
	
	cyg=c:/cygwin64
	home2=$cyg/home/itdlz-koer
	com_alias=$cyg$ZSH_CUSTOM/plugins/common-aliases/common-aliases.plugin.zsh
	ggpl=$cyg$ZSH_CUSTOM/plugins/git/git.plugin.zsh
	pg=$cyg$ZSH_CUSTOM/plugins/python/python.plugin.zsh

	bim=$(wmic OS get OSArchitecture)
	bi2=$(set | findstr ARCH)
	arc=`uname -a |cut -d' ' -f 6`
	dowDir=$home/Downloads
	mteDir=$home2/mte/my-app
	alias acl='apt-cyg listall'
	alias acl2='cygcheck'
	zr=$home2/.zshrc

	
fi


if [[ $os = "Linux" ]] ;then;if [[ $lsb = 'Arch' ]]; then;pm='pacman'
elif [[ $lsb = Ubuntu ]];then;
	pm='apt-get';
	alias mip="echo $(dig +short myip.opendns.com @resolver1.opendns.com)"

 fi;else;pm='apt-cyg';fi


function sortieren_datum(){
	ls -lt $1| grep "^-" | awk '{
	key=$6$7
	freq[key]++
	}
	END {
	for (date in freq)
			printf "%s\t%d\n", date, freq[date]
	}'| sort -k2|tail -n2
}


function hilfe(){
	echo "\n${bold}Hilfe, os: $os"
	schleife=2
	echo "Argumente für $1:${normal}"

	for var in ${@:$schleife} ; do; echo $var;done
}


function b(){	
	if [[ $lsb = 'Ubuntu' ]];then
		/root/src/src_geany-1.28/usr/bin/geany $1 &
	elif [ $os = "CYGWIN_NT-6.1" ];then
		notepad++ $1 &
	# android und arch
	else 
		vi $1 &
	fi

}

function ci2(){
	if [[ $lsb = 'Ubuntu' ]];then
		echo "$1"|xclip
	else
		echo $1 > /dev/clipboard
	fi
}

ci(){
	echo "$1"|xclip -selection clipboard
}
	

function co(){
	if [[ $lsb = 'Ubuntu' ]];then
	xclip -o
	else
	cat /dev/clipboard
	fi
}

function dif(){
	diff <(pdftotext -layout $1 /dev/stdout) <(pdftotext -layout $2 /dev/stdout)
	
}


function ersetz(){

	for file in *; do
		if [[ $file =~ \  ]];then
			echo mit Leerzeichen: $file
			mv "$file" "${file// /_}"
		fi
		
		if [[ $file =~ '[A-Z]' ]];then
		echo Zu verändern: $file
		rename 'y/A-Z/a-z/' *
		fi
		
		if [[ `pwd` = '/root/uni/c' && $file != *"c_"* ]]; then
			mv "$file" ${1}${file}
			echo Zu verändern: $file
		fi
	done
	echo "\n${bold}Dateien nach Op $normal"
	for f in *;do;echo $f;done

}


function ig(){
	if [ $os = "Linux" ]; then;ifconfig;else;ipconfig;fi
}


function in(){

	dfh
	if [[ $os = "Linux" ]] ;then
			     if [[ $lsb = 'Arch' ]]; then; pacman -S --noconfirm $1
                else;apt-get install -y $1;fi
	else
		apt-cyg install $1
	fi

	df -h
}

ip2(){
		ip addr show $1 | grep -Po 'inet \K[\d.]+'
}
compdef _ip ip2


function ipbas {
	
	ipbas=$(echo `ip2 $1` | cut -d . -f -3)	
	echo Basis Ip $ipbas
}

compdef _ip ipbas

function ipd(){

	ip link set $1 down
}
compdef _ip ipd


function ipu(){
		

		ip link set $1 up
}
compdef _ip ipu


function iu(){
		ipd $1;ipu $1
	ig;p
}
compdef _ip iu


function kil(){
	kill -9 $1

	if [ -z "grep $1 =(ps aux)" ];then
		echo Prozess gekillt
	fi
	
	echo "Prozesse mit $1 \n";
	ps -ef|grep $1
}


function ki(){
		killall $1;
		echo "Prozesse mit $1 \n"
		ps -ef|grep $1
}


# login remote shell
function lss(){
	if [ -z "$1" ]; then
	  hilfe `basename $0` "Interface" "letztes Oktett von ip " "opt. port"
	  return
	fi
	ipbas $1

	ssh $3 $ipbas.$2 
}

function mr(){
	zparseopts -A ARGUMENTS f:

	f=$ARGUMENTS[-f]

	printf 'Argument ist "%s"\n' "$f"
	mplayer "$f"
}

compdef _ml mr

function mo(){
	dev=`lsblk|sed -n 5p|cut -f1 -d' '`
	mount /dev/$dev $mediaDir
}

	
function mp(){
	mupdf $1 &
}

mv0(){
	mvn clean compile assembly:single  -e
	#pkill java
	echo .. compile fertig
	java -jar target/my-app-2.jar 
	#pr2 jav

#	echo ..jar hintergrund
	#tmux split-window "zsh;sleep 2;target/classes; ja LClient;read"
}

function nm(){
	ipbas $1;nmap -sP $ipbas.1/24
}
compdef _ip nm
	
function p(){
	ping `if [ $os = Linux ]; then;echo -c 4;fi` google.de
	
}

function pd(){
	if [ "$1" = -he ]; then
	  hilfe `basename $0`  "Paket installiert?"
	  return
	fi

	if [[ $os = "Linux" ]] ;then
		if [[ $lsb = 'Arch' ]]; then;pacman -Qeq |grep $1
	else
		dpkg -l	|grep $1
		fi;else cygcheck -c|less;fi
}

function pen(){
	while true; do
		echo "telnet/curl 178.27.250.8 8000"
		curl 178.27.250.8:8000
		sleep 30m
	done
}

pk(){
	pkill $1;ps $1
}


function pr2(){
	if [ -z "$1" ]; then
	  hilfe `basename $0` "grep mit 'prozess Substitution'" "Prozess"
	  return
	fi
	grep $1 =(ps aux)
}


function int_trap() {
    echo "Ctrl-C gedrückt"
}


function q(){
	# zeige WLAN ssid (iwget)
	if [[ $os != "CYGWIN_NT-6.1" && $arc != 'Android' && `uname -m` != 'armv7l' ]]; then

		iwgetid -r;printf "\n";
	fi
	datei=test100.zip

	trap int_trap INT
	echo Ctrl-C zum Beenden des downloads $datei

	wget http://speedtest.wdc01.softlayer.com/downloads/$datei `if [[ $os = "Linux" && $arc != 'Android' ]]; then ; echo --output-document=/dev/null;fi`
	
	if [ -f $datei ];then ; rm $datei; echo "$datei wird gelöscht"; fi	
	echo Ende
}


function rem(){
	if [ $os = "CYGWIN_NT-6.1" ]; then;apt-cyg remove $1;else
	if [[ $lsb == 'Arch' ]] ;then;pacman -R --noconfirm $1
	else;apt-get autoremove $1;fi
	fi
}
# -f[datei]:dateiname:_files' '-i[interface]:interf:_net_interfaces' '-o[letztes Oktett]' '-d[ziel]'
function sc2(){
	zparseopts -A ARGUMENTS d:f:i: o:u:

	dir=$ARGUMENTS[-d]
	datei=$ARGUMENTS[-f]
	interface=$ARGUMENTS[-i]
	oktett=$ARGUMENTS[-o]
	user=$ARGUMENTS[-u]

	printf 'dir, datei %s %s', $dir,$datei
	
	ipbas $interface
	
	if [ -z $user ];user=root

	scp  $datei $user@$ipbas.$oktett:$dir
	rm -rf $datei
	echo $datei gelöscht vom Server
}
compdef _sc2 sc2


function schieb(){
	
	if [ "$1" = -h ]; then
	  hilfe `basename $0` "anzahl Dat" "Ziel (optional)"
	  return
	fi
	
	ziel_dir=`pwd`
	#ziel_dir=~/root
	
	#if [ -d $2 ];then;ziel_dir=$2;fi
	for i in `seq 1 $1`; do; 	
		dat="$dowDir/`ls -t $dowDir | head -n1`"
		echo $dat
		mv $dat $ziel_dir

		echo aktuelle Datei $ziel_dir/`ls -t $ziel_dir | head -n1`
	done
}

compdef _schieb schieb

function scmysql(){
	
	mysqldump d> $(date +"%m_%Y").sql
	scp `ls -t | head -n1` 192.168.0.148:/root/sqlBack
	#lö $(date +"%m_%Y").sql
}


function sho(){

	if [ $os = "CYGWIN_NT-6.1" ]; then
		apt-cyg show `echo $1`;else ; if [[ $lsb == 'Arch' ]] ;then;pacman -Ss $1 ;else;apt-cache show $1|less;fi;fi;
}

function si(){
	
	secs=$(($1 * 6))
	while [ $secs -gt 0 ]; do
	   echo -ne "$secs\033[0K\r"
	   sleep 1
	   : $((secs--))
	done
	$(2)
}


function unt(){
	#schieb
	a=$(schieb)
	cd `pwd`
	tar xvf $a
	#rm $a
}


function u(){
	
	ps -ef |grep $pts/$1
}
compdef _pts u


function up(){

	if [[ $lsb == 'Arch' ]] ;then;
	pacman -Syu 
	exit
	fi
	apt-get update	
	apt-get upgrade	
	apt-get dist-upgrade	
}

function uz(){
	unzip $1;rm $1
}


yt2(){
	typeset -A assoc_array
	assoc_array=('classic1' 'hSnD30bcAS8'
	'classic2' '2dgPv7vH_BQ' 
	'pop1' 'glkT4AhKrcI'
	)

	for k in "${(@k)assoc_array}"; do
	  echo yt "https://www.youtube.com/watch?v=$assoc_array[$k]"
	done
}

 
# alias/Funktionen
alias al='alias|grep'
alias am='alias -m'
alias d='declare -f'
alias t='type'
alias wh="which"

# betriebssystem
alias lsb="echo $lsb"	
alias os="echo $os"
alias arc="echo $arc"


#cd's
alias ar="cd ~/arduino"
alias y="cd"
alias da="cd ~/django"
alias dow="cd $dowDir"
alias mu="cd ~/musik"
alias mte='cd $mteDir'
alias o='cd $ZSH_CUSTOM'
alias oh='cd $ZSH'
alias op='/opt/git/pr.git'
#alias u='cd ~/uni'
alias uc='cd ~/uni/c'
alias vs='cd ~/vs/vs'

#curl
alias c='cu -L tk1.biz'
alias cm='cu http://178.27.250.8:8000/de/admin/'
alias cu='curl'


#Dateiops
alias cp='cp -r'
alias lö='rm -rf'
alias to='touch'

#Dateisystem
alias lk="lsblk"

#Dict
alias wl="echo Dict.;dict -D"
alias w="dict -d fd-eng-deu"
alias w2="dict"

#Dokumente
alias -s pdf=mupdf


# Editoren
alias v="vim"
alias ab="abiword"


# Energie
alias -g hi='sudo hibernate'
alias s='sudo pm-suspend'


# head / tail
alias -g H='| head'
alias tai='tail -f'
alias -g ti='| tail'

# Hilfe
alias -g h="he"
alias -g he="--help |less"
alias -g hd="$com_alias"
alias hg="g $com_alias"

# Java
alias j="javac"
alias ja="java"


#Komprimierung
alias -s zip="unzip -l"
alias -s rar="unrar l"
alias -s tar="tar tf"


# Konsole
alias hs='\history -E'
alias ho='ec $HOST'
alias pz='pr3 zsh'
alias tt='tty'
alias us='ec $USER'

# ls
alias lr='ls -tRFh'   #sortiert nach Datum,rekursiv,Typ,human readable
alias lsh="ls -halt --full-time"


#mysql
alias msd='mysql -uroot d'
alias mst='mysql -uroot d -e "show tables"'


# netzwerk
alias f='iwgetid -r'
alias -g re='178.27.250.8'
alias iw2='iwlist wlan0 scan'
alias ji='iw2 n'
alias jo='journalctl -xe'
alias ne='/etc/init.d/networking restart;sleep 1;ig'
alias z='ne'


# ps
alias ks="ki ssh"
alias ph="pr2 ssh"
alias pr3='ps -ef|grep'
alias psl="pr2 sleep"
alias -g sl="sleep"

# Radio
alias b1="ml http://br-br1-nbopf.cast.addradio.de/br/br1/nbopf/mp3/128/stream.mp3"

alias ml="mplayer"
alias ra="ml http://80.237.156.8:8120" # landsberg int.

#tmux
alias ta="tmux attach"
alias tk="tmux kill-session"
alias tl="tmux ls"
alias tm="tmux"


# zsh
alias e="exec zsh"
alias ohmyzsh="b $ZSH/oh-my-zsh.sh"
alias ohm='sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"'
alias plu='ec $plugins'
alias pro='ec $prompt'
alias rt="ec $RANDOM_THEME"
alias zr='b $zr' # zshrc 
alias zt="ec $ZSH_THEME"


alias ac='ack'
alias ad2='echo 01573 9598 220 timo.koerner@hof-university.de'
alias ca='cat'
alias dt='date +"%T"'
alias dfh='df -h'
alias dowDir='l $dowDir'
alias duh='du -h'
alias ec="echo"
alias fd='find . -type d -name'
alias ff='find . -type f -name'
alias fin="find / -name"
alias -g gr="|grep -i"
alias gp="g++"
alias hgrep="fc -El 0 | grep"
alias his='history'
alias le='less -WiNS'
alias m='man'
alias mt='man terminator'
alias -g n2='|less'
alias r='expect $login_rp'
alias rf='rfkill list'
alias ter='if [ $os != "CYGWIN_NT-6.1" ]; then;terminator &;else; mintty;fi'
alias tp='top'
alias tr='tree'
alias -g ve="--version"
alias x="exit"
alias yt='	youtube-dl -x --audio-format mp3 --audio-quality 0 -o "%(title)s.%(ext)s"'

echo "$0 aktualisiert"
