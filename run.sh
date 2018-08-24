#!/bin/bash
if [ ! -f /.root_pw_set ]; then
	echo "==================================================================="
	echo "Setting root password to $_ENV['ROOT_PASS']"
	echo "root:$_ENV['ROOT_PASS']" | chpasswd
	echo "=> Done!"
	echo "-------------------------------------------------------------------"
	echo "Creating user '$_ENV['USER_NAME']' with password $_ENV['USER_PASS']"
	adduser --disabled-password --gecos "" $_ENV['USER_NAME'] 
	adduser $_ENV['USER_NAME'] sudo
	chown -R $_ENV['USER_NAME']:$_ENV['USER_NAME'] /home/$_ENV['USER_NAME']
	echo "$_ENV['USER_NAME']:$_ENV['USER_PASS']" | chpasswd
	echo "=> Done!"
	touch /.root_pw_set
	echo "==================================================================="
fi

exec /usr/sbin/sshd -D
