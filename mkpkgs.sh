#!/bin/bash

cp -v ~/Pkgs/*.pkg.* ~/Repos/wwebsiteasontheinternet/pkgs
repo-add -s -k 4B2076CA -v ~/Repos/wwebsiteasontheinternet/pkgs/0X1A.db.tar.gz ~/Repos/wwebsiteasontheinternet/pkgs/*.pkg.*
