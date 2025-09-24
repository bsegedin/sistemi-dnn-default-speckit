# Core App

## Dependencies
This app depends on the following file:
- `~\\App_Code\\Core\\CoreHelpers.cs`

## Features
The Core App provides the following functionalities:
- **PageLinks** – Manage and use page links in themes
- **Audit** – Track and log important events or changes
- **Instructions** – Provide documentation or guidance for users or developers

## Installation
To install and configure the Core App:

1. **Install the App Package:**
   - Navigate to the following path and install the app:
     ```
     \\\\file\\files\\Software\\Development\\_DNN\\_StarterKit\\v4\\2sxc Apps\\Core\\
     ```

2. **Add Supporting Code Files:**
   - Copy the contents of:
     ```
     \\\\\file\\files\\Software\\Development\\_DNN\\_StarterKit\\v4\\2sxc Apps\\_DnnAppCode\\Core\\
     ```
     into the following folder within your DNN installation:
     ```
     ~\\App_Code\\Core\\
     ```

3. **Enable PageLinks in Base Theme:**
   - If you want to use PageLinks data in your Base theme, ensure that the correct `ZoneId` and `AppId` values are provided in:
     ```
     \\Portals\\_default\\Skins\\Base\\controls\\_ctrl-2sxc-links.ascx
     ```
     Alternatively, you can include these attributes in the `\\_inc-theme-body.ascx` file where the 2sxc links control is used.

## Deployment Notes
- Any modifications made in the 2sxc Core app component need to be deployed in:
  - The DNN default repository: [sistemi-dnn-default](https://team.sistemi.hr/tfs/DefaultCollection/Sistemi/_git/sistemi-dnn-default)
  - The releases folder:
    ```
    \\\\file\\files\\Software\\Development\\_DNN\\_StarterKit\\v4\\2sxc Apps\\Core\\
    ```

## Release Notes

### 2.1.0 – 2024-04-22
- Updated `package.json` and `README.md`

### 2.0.0 – 2024-03-24
- New version released for StarterKit v4

### 1.0.0 – 2022-07-24
- Initial version of the Core App
