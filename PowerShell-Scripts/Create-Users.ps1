cat > ~/SecureStratos-SOC-Lab/PowerShell-Scripts/Create-Users.ps1 << 'EOF'
# Secure Stratos Lab — Bulk User Creation
# Run in Azure Cloud Shell (PowerShell)
# Connect first: Connect-MgGraph -Scopes "User.ReadWrite.All" -UseDeviceAuthentication

$domain = "securestratos.onmicrosoft.com"

$passwordProfile = @{
    ForceChangePasswordNextSignIn = $true
    Password = "NotSecure!"
}

$users = @(
    @{ DisplayName="IT Admin";       UserPrincipalName="it.admin@$domain";       MailNickname="it.admin";       Department="IT";      JobTitle="Global Admin";           AccountEnabled=$true; PasswordProfile=$passwordProfile },
    @{ DisplayName="Intune Admin";   UserPrincipalName="intune.admin@$domain";   MailNickname="intune.admin";   Department="IT";      JobTitle="Intune Administrator";   AccountEnabled=$true; PasswordProfile=$passwordProfile },
    @{ DisplayName="SecOps Admin";   UserPrincipalName="secops.admin@$domain";   MailNickname="secops.admin";   Department="SOC";     JobTitle="Sentinel Analyst";       AccountEnabled=$true; PasswordProfile=$passwordProfile },
    @{ DisplayName="Helpdesk User";  UserPrincipalName="helpdesk.user@$domain";  MailNickname="helpdesk.user";  Department="IT";      JobTitle="Helpdesk Administrator"; AccountEnabled=$true; PasswordProfile=$passwordProfile },
    @{ DisplayName="HR Manager";     UserPrincipalName="hr.manager@$domain";     MailNickname="hr.manager";     Department="HR";      JobTitle="HR Manager";             AccountEnabled=$true; PasswordProfile=$passwordProfile },
    @{ DisplayName="Finance Manager";UserPrincipalName="finance.manager@$domain";MailNickname="finance.manager";Department="Finance"; JobTitle="Finance Lead";           AccountEnabled=$true; PasswordProfile=$passwordProfile },
    @{ DisplayName="Sales Manager";  UserPrincipalName="sales.manager@$domain";  MailNickname="sales.manager";  Department="Sales";   JobTitle="Sales Manager";          AccountEnabled=$true; PasswordProfile=$passwordProfile }
)

foreach ($user in $users) {
    try {
        New-MgUser -BodyParameter $user | Out-Null
        Write-Host "Created: $($user.UserPrincipalName)" -ForegroundColor Green
    }
    catch {
        Write-Host "Failed: $($user.UserPrincipalName) — $($_.Exception.Message)" -ForegroundColor Red
    }
}
EOF