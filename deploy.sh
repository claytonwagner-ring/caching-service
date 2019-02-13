# This script is to install heroku-cli, create an app on heroku, and add redis addon 
# HEROKU_LOGIN - Your Heroku login, probably your email address
# HEROKU_API_KEY - Your Heroku API key
# $1 - App name(passing as an argument) to be created on Heroku
#!/bin/bash

echo "Installing Heroku-cli"
curl https://cli-assets.heroku.com/install.sh | sh

echo "log in to heroku"
heroku login -i

# a .netrc file can also be written to avoid running 'heroku login' 

#echo "Writing .netrc file" (either of the logging methods can be used)
#cat >~/.netrc <<EOF
#machine api.heroku.com
#  login ${HEROKU_LOGIN}
#  password ${HEROKU_API_KEY}
#machine git.heroku.com
#  login ${HEROKU_LOGIN}
#  password ${HEROKU_API_KEY}
#EOF

echo "creating app on heroku"
heroku create -a $1

echo "Install heroku-redis plugin"
heroku plugins:install heroku-redis

echo "Adding a redis addon to app"
heroku addons:create heroku-redis:hobby-dev -a $1

sleep 15

echo "output the heroku config"
heroku config -a $1| grep REDIS
