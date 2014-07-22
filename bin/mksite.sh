SITE=/usr/share/nginx/html/
BUILD=_site

cd ../
jekyll build
sudo cp -R $BUILD/* $SITE
