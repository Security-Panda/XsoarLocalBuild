#! /bin/bash

multipass launch --disk 30G --mem 4G --name demisto-local-dev
multipass mount $(pwd)/Setup demisto-local-dev
multipass exec demisto-local-dev -- sudo chmod +x $(pwd)/Setup/demistoserver-*.sh
multipass exec demisto-local-dev -- sudo $(pwd)/Setup/demistoserver-*.sh --quiet --accept
sleep 180
multipass exec demisto-local-dev sudo systemctl restart demisto
