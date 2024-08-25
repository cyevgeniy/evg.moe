#!/bin/sh -ex

deploy() {
  rsync -vzr --delete -e 'ssh -i ~/.ssh/id_ed25519' public/  evgmoe@93.125.99.58:public_html
  echo "Deployed to https://evg.moe"
}

deploy
