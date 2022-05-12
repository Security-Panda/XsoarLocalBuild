# XSOAR Local Content Development
This repository is to help you create a local Ubuntu based Cortex XSOAR server for development. In addition, this also attempts to provide a simpler understanding to the practical implementation of [XSOAR CI/CD](https://xsoar.pan.dev/docs/reference/articles/xsoar-ci-cd). It also helps an engineer to understand the method to push content developed from one xsoar server to any other manually.

# Pre-requisites
- [Install Multipass](https://multipass.run/)
- [Install and configure demisto-sdk](https://xsoar.pan.dev/docs/concepts/demisto-sdk)
- [Get Demistoserver installation script and Community Edition Licence](https://start.paloaltonetworks.com/sign-up-for-community-edition-cxo.html)

# How to use this repo

## 1 - Clone this repo locally

## 2 - Build a local xsoar dev server
- Copy the Demisto server installation script (.sh file) obtained while ensuring pre-requisites into a new folder called 'Setup'.
- Run build_local_dev.sh (the demisto installation script will ask for additional information like port number to run on, username and password to fill in)

## 3 - Connect to the local server using the link provided after installation has finished and add the licence that was provided by signing up to the Community Edition.

## 4 - Build/update required content on local xsoar dev server

## 5 - Prepare to download content from the local server - Get API creds
- On the local server go to "Settings > Integrations > API Keys"
- Click "Get You Key"
- Save the API key for the next step.

## 6 - Prepare to download content from the local server - Set API creds on local terminal
- export the environment variables DEMISTO_BASE_URL and DEMISTO_API_KEY using the following commands:
```
export DEMISTO_BASE_URL="https://<ip>:<port number>"
export DEMISTO_API_KEY="<API Key obtained in step 5>"
```

## 7 - Download developed content as pack from local dev xsoar server
- Clone the [content-ci-cd-template](https://github.com/demisto/content-ci-cd-template) and cd into it. This is the template provided by Palo and the  directory structure is necessary for demisto-sdk to work.
- Initialise a new empty pack: `demisto-sdk init -n <content pack name>` (This initialises a directory Packs/<content pack name>)
- Identify all content to be downloaded: `demisto-sdk download -lf --insecure`- Download all associated content: `demisto-sdk download -i "<name of content>" -o Packs/<content pack name> --insecure`

## 5 - Update dependencies
- `demisto-sdk find-dependencies -i Packs/<content pack name> --use-pack-metadata`

## 6 - Zip the pack into uploadable format
- `demisto-sdk zip-packs -i Packs/<content pack name> -o Packs`

## 8 - Install content as a pack to a different server
- Upload Pack using the UI by going to Marketplace > Click three dots on the top right > Click "Upload Content Packs"

### Alternate to step 8
- Follow steps 5 and 6 to get API connection into the the server where you want to install the pack.
- Run the command `demisto-sdk upload -i Packs/uploadable_packs/<content pack name>.zip --insecure`

### Additional Steps if updating existing content
- Upload the content to be edited into the local xsoar dev server: `demisto-sdk upload -i Packs/<content pack name>`
- Delete the content pack from the repo: `rm -rf Packs/<content pack name>`

