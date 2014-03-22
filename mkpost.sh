#!/bin/bash

DATE=$(date +%Y-%m-%d)
echo "Enter post filename:"
read PSTNME
POST=$DATE-$PSTNME.md
touch blog/_posts/$DATE-$PSTNME.md
echo --- > blog/_posts/$POST
echo "layout: post" >> blog/_posts/$POST
echo "Enter title:"
read TTLE
echo "title: \"$TTLE\"" >> blog/_posts/$POST
echo "date: $DATE" >> blog/_posts/$POST
echo "Enter tags:"
read TAGS
echo "tags: $TAGS" >> blog/_posts/$POST
echo --- >> blog/_posts/$POST

vim blog/_posts/$POST
