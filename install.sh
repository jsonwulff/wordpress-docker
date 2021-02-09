#!/bin/bash

echo ">> Spinning up containers..."
docker-compose up -d

sleep 40

echo ">> Updating permalinks..."
docker-compose run --rm --no-deps wpcli option update permalink_structure '/%postname%/'

echo ">> Discourage search engine from indexing"
docker-compose run --rm --no-deps wpcli option update blog_public 0

echo ">> Deleting included posts"
docker-compose run --rm --no-deps wpcli post delete $(docker-compose run --rm --no-deps wpcli post list --post_status=post --format=ids) --force

echo ">> Deleting included plugins"
docker-compose run --rm --no-deps wpcli plugin uninstall hello akismet --deactivate

echo ">> Deleting included plugins"
docker-compose run --rm --no-deps wpcli theme delete --all

echo ">> Updating WordPress"
docker-compose run --rm --no-deps wpcli core update