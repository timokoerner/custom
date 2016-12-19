
# Remove python compiled byte-code in either current directory or in a
# list of specified directories
function pyclean() {
    ZSH_PYCLEAN_PLACES=${*:-'.'}
    find ${ZSH_PYCLEAN_PLACES} -type f -name "*.py[co]" -delete
    find ${ZSH_PYCLEAN_PLACES} -type d -name "__pycache__" -delete
}


alias dv='python -c "import django;print(django.get_version())"'
alias p3="python3"
alias py='/root/progr/pycharm/bin/pycharm.sh&'


# python django
alias d0='d1;d2;dr'
alias d2='kill $(netstat -lnp | grep 8000 | awk "{print $7}" | cut -d"/" -f 1)'
alias dr='p3 wsgi/myproject/manage.py runserver&'
alias ma='p3 wsgi/myproject/manage.py'
alias d1="cd ~/django"
alias mk="p3 wsgi/myproject/manage.py makemigrations"
alias mi="p3 wsgi/myproject/manage.py migrate"


#pip
alias pi3='p3 -m pip install'
alias p3i=pi3
alias pui3='pip3 uninstall'
alias pl3='p3 -m pip list'
alias req='pi3 -r requirements.txt'
