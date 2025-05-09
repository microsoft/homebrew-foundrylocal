# Install Foundry Local on mac

If you are seeing this README, then you have access to this private repo and you have the ability to install the Foundry Local mac installer.

Once Foundry Local is in Public Preview, this repo will be public and you will not need to authorize with a token.

## Install for mac when you are an external contributor

1. Create a GitHub PAT (personal access token):
   - Go to `Settings -> Developer Settings`
   - Generate new token (classic)
   - Click the `repo` button to give your token acccess to the private repo
   - Press `Generate Token` and copy the token value
  
 2. Set HOMEBREW_GITHUB_API_TOKEN:
    - `export HOMEBREW_GITHUB_API_TOKEN=<Github_TOKEN>`

 3. Install Foundry Local using homebrew
    - brew tap microsoft/foundrylocal
    - brew install foundrylocal
   
## Install for mac when you are a Microsoft employees

Note: these instructions assume you are using your personal GitHub account and it is linked with the Microsoft GitHub organization.

1. Create a GitHub PAT (personal access token):
   - Go to `Settings -> Developer Settings`
   - Generate new token (classic)
   - Click the `repo` button to give your token acccess to the private repo
   - Press `Generate Token` and copy the token value
   - **Configure SSO and authorize Microsoft**
  
 2. Set HOMEBREW_GITHUB_API_TOKEN:
    - `export HOMEBREW_GITHUB_API_TOKEN=<Github_TOKEN>`

 3. Install Foundry Local using homebrew
    - brew tap microsoft/foundrylocal
    - brew install foundrylocal
   
## Uninstall

`brew rm foundry local`

      



