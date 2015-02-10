#!/bin/bash

PREREQ="git rsync"
for PR in $PREREQ;do
  if [ -z "$(which $PR)" ];then
    echo "$PR not found! Please install $PR."
    exit 1
  fi
done

MY_PATH="`dirname \"$0\"`"              # relative
MY_PATH="`( cd \"$MY_PATH\" && pwd )`"  # absolute

echo "MY_PATH=$MY_PATH"
cd $MY_PATH

echo "This script will"
echo
echo "1) copy this whole project into a new folder ../<app_name>,"
echo "2) setup a ../<app_name>/.vagrant.local.yml file with the given <app_name>,"
echo "3) cd ../<app_name>/;vagrant up to create a new rails app called <app_name> inside the vagrant box,"
echo "4) cd ../<app_name>/;git init; git add --all;git commit -m 'intial import' to have everything under version control right from the start."
echo
echo "Afterwards you will find your new Rails App here:"
echo
echo "http://localhost:30000"
echo
echo "A PhpMyAdmin for the MySQLDBs of your Rails App you'll find here:"
echo
echo "http://localhost:8080/phpmyadmin/"
echo "(User: root, Password: <empty>)"
echo

APP_NAME_VALID=0
APP_NAME=""
while [ $APP_NAME_VALID -eq 0 ];do
  echo "Please enter the desired app_name and press [ENTER]: "
  read APP_NAME
  if [[ $APP_NAME =~ ^[a-z0-9_-]+$ ]];then
    echo
    echo "app_name $APP_NAME is valid!"
    echo
    APP_NAME_VALID=1
  else
    echo
    echo "app_name $APP_NAME is not valid!"
    echo "Please use only a-z, 0-9 or _ in app_name."
    echo
  fi
done
while [ -d ../$APP_NAME ];do
  BACKUP_FOLDER=${APP_NAME}.$(date +%Y%m%d_%H%M%S)
  echo
  echo "Projectfolder ../$APP_NAME already exists!"
  echo "Shall I move it to $BACKUP_FOLDER [y|n]? "
  read YESNO
  if [ "$YESNO" = "y" ];then
    mv ../$APP_NAME ../$BACKUP_FOLDER
  else
    echo "Ok, then I'll exit now."
    exit 1
  fi
done

echo "Copying project folder into ../$APP_NAME ..."
mkdir ../$APP_NAME
rsync -n -avx --exclude=.git ./ ../$APP_NAME/
exit
echo "cd-ing into new folder ../$APP_NAME"
cd ../$APP_NAME

echo "Creating a local vagrant.local.yml file..."
cat <<EOF > vagrant.local.yml
---
settings: {
  app_name: $APP_NAME
}
EOF
echo "Building the vagrant box..."
vagrant up
if [ $? -ne 0 ];then
  echo "Something went wrong. Exiting."
  exit 1
fi

echo "Putting everything under versioncontrol..."
git init
git add --all
git commit -m 'intial import'

echo "Everything is done."
echo "Here is your new Rails App Project:"
ls -1
echo
echo "To see your new Rails App in action start the buildin webserver with"
echo "vagrant ssh"
echo "cd $APP_NAME"
echo "rails s -b 0.0.0.0"
echo
echo "and point your browser to"
echo "http://localhost:3000"
echo


