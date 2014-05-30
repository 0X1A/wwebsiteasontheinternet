SITE=/usr/share/nginx/html/
BUILD=_site

jekyll build
sudo cp -R $BUILD/* $SITE
