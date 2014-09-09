#!/bin/bash

DATE=$(date +%Y-%m-%d)
echo "Enter post filename:"
read PSTNME
POST=$DATE-$PSTNME.md
touch ../_posts/$DATE-$PSTNME.md
echo --- > ../_posts/$POST
echo "layout: post" >> ../_posts/$POST
echo "Enter title:"
read TTLE
echo "title: \"$TTLE\"" >> ../_posts/$POST
echo "date: $DATE" >> ../_posts/$POST
echo "Enter tags:"
read TAGS
echo "tags: $TAGS" >> ../_posts/$POST
echo "Enter description:"
read DESC
echo "desc: $DESC" >> ../_posts/$POST
echo --- >> ../_posts/$POST

vim ../_posts/$POST
