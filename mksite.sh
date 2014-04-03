SITE=/var/www/
BUILD=_site

jekyll build
sudo cp -R $BUILD/* $SITE
