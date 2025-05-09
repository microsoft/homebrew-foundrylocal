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


## Contributing

This project welcomes contributions and suggestions.  Most contributions require you to agree to a
Contributor License Agreement (CLA) declaring that you have the right to, and actually do, grant us
the rights to use your contribution. For details, visit https://cla.opensource.microsoft.com.

When you submit a pull request, a CLA bot will automatically determine whether you need to provide
a CLA and decorate the PR appropriately (e.g., status check, comment). Simply follow the instructions
provided by the bot. You will only need to do this once across all repos using our CLA.

This project has adopted the [Microsoft Open Source Code of Conduct](https://opensource.microsoft.com/codeofconduct/).
For more information see the [Code of Conduct FAQ](https://opensource.microsoft.com/codeofconduct/faq/) or
contact [opencode@microsoft.com](mailto:opencode@microsoft.com) with any additional questions or comments.

## Trademarks

This project may contain trademarks or logos for projects, products, or services. Authorized use of Microsoft 
trademarks or logos is subject to and must follow 
[Microsoft's Trademark & Brand Guidelines](https://www.microsoft.com/en-us/legal/intellectualproperty/trademarks/usage/general).
Use of Microsoft trademarks or logos in modified versions of this project must not cause confusion or imply Microsoft sponsorship.
Any use of third-party trademarks or logos are subject to those third-party's policies.

      



