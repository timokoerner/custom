da=/home/pi/django/
soup=$da/soup.py

# Entferne python kompilierter byte-code im aktuellen Verzeichnis oder in einer Verzeichnisliste
function pyclean() {
    ZSH_PYCLEAN_PLACES=${*:-'.'}
	find . -path '*/__pycache__/*' -delete
    find ${ZSH_PYCLEAN_PLACES} -type d -name "__pycache__" -delete
}

function p3(){
	if [ $os != "CYGWIN_NT-6.1" ]; then

		python3 $@
	else
		python $@;fi
}

function pd(){
	pipdeptree -r --package $1
	echo "\n"
	pip show $1
}

function sess(){
	#((!$#))&&
	sed -i "s/\(cd = { 'sessionid':\).*/\1 \'$1\'}/" $soup
	ec \'$1\'
	python3 $soup
}


alias iy='ipython'
alias da=$da
alias op=/opt/django.git
alias pyc='/root/progr/pycharm/bin/pycharm.sh&'

#pip
alias pdt='pipdeptree --package'
alias pdr='pipdeptree -r --package'
alias pe='pip search'
alias pi='pip show'
alias pin='pip install'
alias pl='pip list'
alias pu='pip uninstall -y'
alias po='pip list --outdated f'
alias pll='pip list f'
alias sp='c $soup | sed -n 4p'
