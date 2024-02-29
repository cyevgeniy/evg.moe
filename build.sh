#!/bin/sh -ex

deploy() {
  rsync -vzr --delete -e 'ssh -i ~/.ssh/id_ed25519' public/  proj11co@93.125.99.59:public_html
  echo "Deployed to https://proj11.com"
}

deploy
