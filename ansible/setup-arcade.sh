#!/usr/bin/env bash
if [[ ! -d ~/.ssh ]]; then
  echo "Creating .ssh folder"
  mkdir ~/.ssh
  chmod 700 ~/.ssh
fi
if [[ ! -f ~/.ssh/known_hosts ]]; then
  echo "Adding localhost fingerprint to known hosts"
  ssh-keyscan -H 127.0.0.1 >> ~/.ssh/known_hosts
fi
ansible-playbook -s -i hosts arcade.yml
