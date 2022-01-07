# Gumroad License Validator

## Overview
A super simple tool for macOS Swift developers to check validity of a Gumroad-issued software license keys

## Requirements
Requires macOS 12 because it uses async/await APIs. 

If you really need it to have a completionHandler-based synchronous version, let me know

## Installation
Swift-Gumroad-license-validator is available through [Swift Package Manager](https://swift.org/package-manager/).
1. In Xcode, click File > Add Packages...
2. Select GitHub under Source Control Accounts
3. Search for Swift-Gumroad-license-validator
4. Click "Add Package" in bottom right

## Usage
```swift
    import GumroadLicenseValidator
```
    
```swift
    let licenseKeyToCheck = "XXXXXXXX-XXXXXXXX-XXXXXXXX-XXXXXXXX"
    
    let client = GumroadClient(productPermalink: "your product permalink")
    
    await client?.isLicenseKeyValid(licenseKeyToCheck)
```
## How to get a product permalink from Gumroad
Go to your product page on Gumroad. 

If your product URL is "https://gumroad.com/l/QMGY" your product_permalink would be "QMGY."

## How to get a test license key from Gumroad
1.  Log in to your Gumroad account, open your product
2.  Click the URL underneath your product's name to open the page
3.  Click the purchase button ("I want this”, ”Buy”, or whatever you set it up to be)
4.  You will see a checkout window with test card information already entered
5.  Confirm the purchase, and then click “View content” to get the code (you'll also get it in an email)

## Good luck with your project
If you're using this package it means you've decided to sell your app on Gumroad. May you have an exciting launch and many sales! Good luck! I'd love it if you let me know about your app, [@DanielKasaj on Twitter](https://twitter.com/DanielKasaj).

## License
Swift-Gumroad-license-validator is available under the MIT license. See the [LICENSE](LICENSE) file for more information.

