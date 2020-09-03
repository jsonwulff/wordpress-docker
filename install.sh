#!/bin/bash

echo ">> Spinning up containers..."
docker-compose up -d

# ## Get variables from .env file
# # if [ -f .env ]
# # then
# #   export $(grep -v '^#' .env | xargs)
# # fi

# echo ">> Installing WordPress..."
# # docker-compose run --rm --no-deps wpcli core install \
# #     --url=$WORDPRESS_DOMAIN \
# #     --title=$WORDPRESS_TITLE \
# #     --admin_user=$WORDPRESS_ADMIN_USER \
# #     --admin_email=$WORDPRESS_ADMIN_EMAIL\
# #     --admin_password=$WORDPRESS_ADMIN_PASS \

echo ">> Updating permalinks..."
docker-compose run --rm --no-deps wpcli option update permalink_structure '/%postname%/'

echo ">> Discourage search engine from indexing"
docker-compose run --rm --no-deps wpcli option update blog_public 0

echo ">> Deleting included posts, plugins, themes and comments"
docker-compose run --rm --no-deps wpcli post delete 1 --force
# docker-compose run --rm --no-deps wpcli plugin deactivate hello akismet
docker-compose run --rm --no-deps wpcli plugin uninstall hello akismet --deactivate
# docker-compose run --rm --no-deps wpcli plugin delete hello akismet