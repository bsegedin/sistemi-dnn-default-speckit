# Content Blocks App

## Dependencies
This app depends on the following file:
- `~\\App_Code\\Core\\CoreHelpers.cs`

## Features
Provides reusable website building blocks for:
- **Text**
- **Images**
- **Videos**

## Installation
To install and configure the Content Blocks App:

1. **Install the App Package:**
   - Get the latest version from:
     ```
     \\\\file\\files\\Software\\Development\\_DNN\\_StarterKit\\v4\\2sxc Apps\\ContentBlocks\\
     ```
   - Install it in your DNN 2sxc App module.

2. **Add Supporting Code Files:**
   - Copy the contents of:
     ```
     \\\\file\\files\\Software\\Development\\_DNN\\_StarterKit\\v4\\2sxc Apps\\_DnnAppCode\\Core\\
     ```
     into the following folder in your DNN installation:
     ```
     ~\\App_Code\\Core\\
     ```

## Deployment Notes
- Any modifications made in the 2sxc Content Blocks app component need to be deployed in:
  - The DNN default repository: [sistemi-dnn-default](https://team.sistemi.hr/tfs/DefaultCollection/Sistemi/_git/sistemi-dnn-default)
  - The releases folder:
    ```
    \\\\file\\files\\Software\\Development\\_DNN\\_StarterKit\\v4\\2sxc Apps\\ContentBlocks\\
    ```

## Release Notes

### 1.3.0 – 2025-06-02
- Added new views: Column Layout For 3 Items, Row Layout For 3 Items, Row Layout For 4 Items
- Removed old Advanced Card and Split
- Upgraded methods for css manipulation in ViewHelpers.cs
- CSS updates

### 1.2.0 – 2025-04-22
- Added shared functionality to display item state badges: **PUB**, **UNPUB**, **DEMO**

### 1.1.0 – 2025-03-10
- Initial version of the Content Blocks app
