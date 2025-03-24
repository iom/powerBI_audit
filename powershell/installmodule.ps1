# Function to Ensure Module Existence
function Install-OrUpdate-Module {
    param(
        [string]$ModuleName
    )

    # Check if the module is available
    $module = Get-Module $ModuleName -ListAvailable -ErrorAction SilentlyContinue

    if (!$module) {
        Write-Host "Installing module $ModuleName ..."
        Install-Module -Name $ModuleName -Force -Scope CurrentUser
        Write-Host "Module installed"
    }
    else {
        Write-Host "Module $ModuleName found."

        # Update the module if it's not the desired version
        if ($module.Version -lt '1.0.0' -or $module.Version -le '1.0.410') {
            Write-Host "Updating module $ModuleName ..."
            Update-Module -Name $ModuleName -Force -ErrorAction Stop
            Write-Host "Module updated"
        }
    }
}

# Check and install/update required module
Install-OrUpdate-Module -ModuleName "MicrosoftPowerBIMgmt"
