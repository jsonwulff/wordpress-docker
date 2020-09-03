# Wordpress docker-compose boilerplate
This is a boilerplate for setting up a wordpress installation using docker-compose with traefik as a reverse proxy on an external docker network. This project also includes WP-cli in order too automate and clean up the installation.

With this project you can quickly run the following:
- [WordPress and WP CLI](https://hub.docker.com/_/wordpress/)
- [MariaDB](https://hub.docker.com/_/mariadb)

Contents:
- [Requirements](#requirements)
- [Configuration](#configuration)
- [Usage](#usage)
- [Development (make wp files writeable)](#development-make-wp-files-writeable)
- [WP-CLI](#wp-cli)
- [Notes](#notes)
- [Improvment ideas](#improvment-ideas)

## Requirements
Make sure you have the latest versions of **Docker** and **Docker Compose** installed on your machine. Make sure your user is added to the docker user group when using Linux. Make sure you have a running Traefik container running as a reverse proxy on a external docker network

## Configuration
Edit the `.env` file with the relevant data. The the Traefik labels for wordpress might be changed to suit your needs aswell as the name of the external network. 

## Usage

### Installation script
You can either run `install.sh` which spins up the containers and perform some cleaning of the wordpress installtion. If the automate `WP-cli` installation does not succed it might be due to the fact that the WordPress container hasn't connected to the database yet. This can be fixed by inscreasing the sleep time command for `WP-cli`

### Start container

```
docker-compose up -d
```

### Stop container

```
docker-compose down
```

### Stop containers and remove persisntent data
Either run the `uninstall.sh` script or use:

```
docker-compose down -v
sudo rm -rf wp
```

## Development (make wp files writeable)
In order to make the files in wp editable, it is necessary to add the www-data user to a user group with the right permissions. Add host user and www-data user to group and logout to take effect

### Make user group
```
sudo groupadd wordpress
```
### Add users to group
```
sudo usermod -a -G groupname username
sudo usermod -a -G groupname www-data
```

### Add user group to file permissions
```
sudo chgrp -R groupname /path/to/the/directory
```

### Change file permission to include user group
```
sudo chmod -R 770 /path/to/the/directory
```

### Links to more information regarding file permission and the aboe
* [Give write permissions to multiple users on a folder in Ubuntu](https://superuser.com/questions/280994/give-write-permissions-to-multiple-users-on-a-folder-in-ubuntu)
* [Understanding File Permissions: What Does “Chmod 777” Mean?](https://www.maketecheasier.com/file-permissions-what-does-chmod-777-means/)

## WP-CLI
Sample command:
```
docker-compose run --rm --no-deps wpcli --info
```
For an easier usage you may consider adding an alias for the CLI to your `.bash_profil`:
```
alias wp="docker-compose run --rm --no-deps wpcli"
```
This way you can use sample command above as follows:
```
wp --info
```

## Notes
* I havn't tested that ${APP_NAME} in the traefik labels actually works.

## Improvment ideas
- [ ] Add PHPMyAdmin to docker-composer.yml
- [X] Add WP-cli to docker-composer.yml
- [X] Run some WP-cli commands to install WP, remove plugins and themes included with WP
- [ ] Include most used plugins
- [ ] Update wp and plugins with WP command