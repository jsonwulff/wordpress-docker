# Wordpress docker boilerplate
This is a boilerplate for setting up a wordpress installation using docker-compose with traefik as a reverse proxy on an external docker network.

> **NOTE:** I havn't tested that ${APP_NAME} in the traefik labels actually works.

## Make /wp-content writeable
In order to make the files in wp editable, it is necessary to add the www-data user to a user group with the right permissions. Add host user and www-data user to group and logout to take effect

### Make user group
```sudo groupadd wordpress```
### Add users to group
```sudo usermod -a -G groupname username```

```sudo usermod -a -G groupname www-data```
### Add user group to file permissions
```sudo chgrp -R groupname /path/to/the/directory```
### Change file permission to include user group
```sudo chmod -R 770 /path/to/the/directory```

### Links to more information regarding file permission and the aboe
* [Give write permissions to multiple users on a folder in Ubuntu](https://superuser.com/questions/280994/give-write-permissions-to-multiple-users-on-a-folder-in-ubuntu)
* [Understanding File Permissions: What Does “Chmod 777” Mean?](https://www.maketecheasier.com/file-permissions-what-does-chmod-777-means/)

## Improvment ideas for this boilerplate
- [] Add PHPMyAdmin to docker-composer.yml
- [] Add WP-cli to docker-composer.yml
- [] Run some WP-cli commands to install WP, remove plugins and themes included with WP
- [] Include most used plugins