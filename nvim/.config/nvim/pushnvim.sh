#!/bin/bash

cd ~/.config/nvim

git add .
git commit -m "auto: nvim config backup on $(date '+%Y-%m-%d %H:%M:%S')"
git push

