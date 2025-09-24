# DNN Base Theme

## Dependencies
This theme depends on the following file:
- `~\\App_Code\\BaseTheme\\ThemeHelpers.cs`

## Core Modifications
- `~\\admin\\Skins\\Search.ascx`

## Features
The Base StarterKit theme serves as a foundation for all apps. It includes basic structure and styles required to develop a new theme.

This version includes 4 skin files and 1 container file:
- `Default.ascx`
- `SingleNarow.ascx`
- `SplitPanesCenter.ascx`
- `SplitPanesFluid.ascx`

## Installation
1. **Copy Theme Files:**
   - Copy the **Base** theme folders from:
     ```
     \\file\\files\\Software\\Development\\_DNN\\_StarterKit\\v4\\DNN Theme\\
     ```
     to your DNN installation (either global or local location).

2. **Add Supporting Code Files:**
   - Copy the contents of:
     ```
     \\file\\files\\Software\\Development\\_DNN\\_StarterKit\\v4\\DNN Theme\\v1\\Base\\_DnnAppCode\\BaseTheme\\
     ```
     into the following folder within your DNN installation:
     ```
     ~\\App_Code\\BaseTheme\\
     ```

## Deployment Notes
- Any modifications made in the Base theme component need to be deployed in:
  - The DNN default repository: [sistemi-dnn-default](https://team.sistemi.hr/tfs/DefaultCollection/Sistemi/_git/sistemi-dnn-default)
  - The releases folder:
    ```
    \\file\\files\\Software\\Development\\_DNN\\_StarterKit\\v4\\DNN Theme\\
    ```

## Release Notes

### 1.0.0 – 2024-04-22
- New version released for StarterKit v4

### 1.0.1 – 2024-04-25
- The modification has been made in the main navigation. The file /nav/main/template.cshtml has been updated. The same markup has been set for both desktop and mobile versions.

### 1.0.2 – 2024-05-26
- Implemented Bootstrap dark mode support. Modified file: /controls/_inc-theme-body.ascx.
