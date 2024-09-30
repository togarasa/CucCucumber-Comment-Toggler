# Cucumber Comment Toggler

This PowerShell script allows you to toggle comments for multiple line ranges in Cucumber `.feature` files. It can be used to easily comment or uncomment scenarios during testing or debugging.

## Features

- Specify multiple line ranges to comment or uncomment.
- Use any comment character (e.g., `#` or `//`).
- Automatically detects whether lines are already commented and toggles them.

## Usage

1. Clone the repository:
    ```bash
    git clone https://github.com/your-username/Cucumber-Comment-Toggler.git
    ```

2. Run the script by specifying the file path, line ranges, and comment character:
    ```powershell
    .\CommentOutLines.ps1 -FilePath "C:\path\to\your\feature.feature" -LineRanges "4-5,8-11" -CommentChar "#"
    ```

3. The script will toggle comments for the specified lines.

## Example

### Before:
```gherkin
Feature: Login

  Scenario: Successful login
    Given the user is on the login page
    When the user enters valid credentials
    Then the user is redirected to the dashboard

  Scenario: Failed login
    Given the user is on the login page
    When the user enters invalid credentials
    Then the user sees an error message
```

### Command:

 ```powershell
    .\CommentOutLines.ps1 -FilePath "C:\path\to\your\feature.feature" -LineRanges "4-5,8-11" -CommentChar "#"

 ```

### After:
```gherkin

  #Given the user is on the login page
  #When the user enters valid credentials
  #Scenario: Failed login
  #Given the user is on the login page
  #When the user enters invalid credentials

```

