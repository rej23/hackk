
    Write-Host -ForegroundColor Cyan "Welcome type start-hackergame to start hacking"

# while ($lockopen -eq "False")
# {


Function Set-LockStatus {
    Param(
        [Switch]$Open,
        [Switch]$Close
    )
    Write-Host "Lock function reports lock open"
    Return "Open"

   
}






Function Start-HackerGame {
    $Device1 = Get-Random -Minimum 1 -Maximum 252
    $Device2 = Get-Random -Minimum ($Device1 + 1) -Maximum 253
    $Device3 = Get-Random -Minimum ($Device2 + 1) -Maximum 254
    $Subnet = Get-Random -Minimum 1 -Maximum 254
    $global:Devices=@("192.168.$Subnet.$Device1","192.168.$Subnet.$Device2","192.168.$Subnet.$Device3")
    $global:CorrectDevice = Get-Random -Minimum 0 -Maximum 2
    $global:Ports = @(80,443,8080)
    $global:CorrectPort = Get-Random -Minimum 0 -Maximum 2
    $global:WrongPorts = @(9,9)
    For ($i=0;$i -lt 3;$i++) {
        If ($i -ne $CorrectPort) {
            If ($WrongPorts[0] -eq 9) {
                $global:WrongPorts[0] = $i
            } Else {
                $global:WrongPorts[1] = $i
            }
        }
    }
    Write-Host "Target Device: $($Devices[$CorrectDevice])"
    Write-Host "Target Port: $($Ports[$CorrectPort])"
    Start-Sleep -Seconds 3
    cls
Write-Host "
               ,---------------------------,
              |  /---------------------\  |
              | |                       | |
              | |        TAKE           | |
              | |         THE           | |
              | |      HACK SEAT        | |
              | |                       | |
              |  \_____________________/  |
              |___________________________|
            ,---\_____     []     _______/------,
          /         /______________\           /|
        /___________________________________ /  | ___
        |                                   |   |    )
        |  _ _ _                 [-------]  |   |   (
        |  o o o                 [-------]  |  /    _)_
        |__________________________________ |/     /  /
    /-------------------------------------/|      ( )/
  /-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/ /
/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/ /
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
start-sleep -Seconds 3
    Get-HackerHelp
}

Function Get-HackerHelp {
    Write-Host -ForegroundColor Green "Hints:"
    Write-Host -ForegroundColor Green "Get-NetworkDevices    Returns a list of devices on the network"
    Write-Host -ForegroundColor Green "Get-OpenPorts         Returns a list of open ports on a device"
    Write-Host -ForegroundColor Green "Invoke-API            Sends commands to a web API"
    Write-Host -ForegroundColor Green "Get-HackerHelp        See this list again"
    Write-Host -ForegroundColor Green "Shortcuts:"
    Write-Host -ForegroundColor Green "Highlight text Shift + Arrow key"
    Write-Host -ForegroundColor Green "Copy    Ctrl + C"
    Write-Host -ForegroundColor Green "Paste   Ctrl + V"

}

Function Get-NetworkDevices {
    Write-Host -ForegroundColor Cyan "Scanning local network for devices..."
    Start-Sleep -Seconds 3
    Write-Host "Device found at address: $($Devices[0])"
    Start-Sleep -Seconds 1
    Write-Host "Device found at address: $($Devices[1])"
    Start-Sleep -Seconds 1
    Write-Host "Device found at address: $($Devices[2])"
    Start-Sleep -Seconds 2
    Write-Host -ForegroundColor Green "Scan Complete"
}

Function Get-OpenPorts ($Address) {
    $HelpText = {'
NAME
    Get-OpenPorts
    
SYNTAX
    Get-OpenPorts -Address <Address>

REMARKS
    Use this command to scan an address for a list of open ports.
    '}
    If (!($Address)) {
        Write-Host -ForegroundColor Red "Error: Address not specified"
        Write-Host $HelpText
        Return
    }
    If ($Address -notlike "*.*.*.*") {
        Write-Host -ForegroundColor Red "Error: Invalid Address"
        Write-Host $HelpText
        Return
    }
    Write-Host -ForegroundColor Cyan "Scanning $Address for open ports..."
    Start-Sleep -Seconds 3
    If ($Address -eq $Devices[$CorrectDevice]) {
        Write-Host "Open Port Found: $($Ports[$CorrectPort])"
    } ElseIf ($Devices -contains $Address) {
        Write-Host "Open Port Found: $($Ports[$WrongPorts[0]])"
        Start-Sleep -Seconds 1
        Write-Host "Open Port Found: $($Ports[$WrongPorts[1]])"
    } Else {
    }
    Start-Sleep -Seconds 2
    Write-Host -ForegroundColor Green "Scan Complete"
}


Function Invoke-API {
    Param(
        $Address,
        $Port,
        [ValidateSet("GET","POST")]$Method,
        $Command
    )
    $HelpText = {'
NAME
    Invoke-API
    
SYNTAX
    Invoke-API -Address <Address> -Port <PortNumber> -Method {Get | Post | Delete} -Command {move | close | open}

REMARKS
    Use this command to send data to a remote API (Application Programming Interface).
    '}
    If (!($Address)) {
        Write-Host -ForegroundColor Red "Error: Address not specified"
        Write-Host $HelpText
        Return
    }
    If ($Address -notlike "*.*.*.*") {
        Write-Host -ForegroundColor Red "Error: Invalid Address"
        Write-Host $HelpText
        Return
    }
    If (!($Port)) {
        Write-Host -ForegroundColor Red "Error: Port not specified"
        Write-Host $HelpText
        Return
    }
    Write-Host "Connecting to $Address ..."
    If ($Address -eq $Devices[$CorrectDevice]) {
        If ($Port -eq $Ports[$CorrectPort]) {
            If ($Method -eq "POST") {
                Start-Sleep -Seconds 1
                Write-Host "Sending command ""$Command"" ..."
                Start-Sleep -Seconds 1
                If ($Command -eq "Open") {
                    If ((Set-LockStatus -Open) -eq "Open") {
                        Write-Host -ForegroundColor Green "Lock status: Open!"
                        write-host "
               ,---------------------------,
              |  /---------------------\  |
              | |                       | |
              | |     CONGRATULATION    | |
              | |        YOU WON        | |
              | |                       | |
              | |                       | |
              |  \_____________________/  |
              |___________________________|
            ,---\_____     []     _______/------,
          /         /______________\           /|
        /___________________________________ /  | ___
        |                                   |   |    )
        |  _ _ _                 [-------]  |   |   (
        |  o o o                 [-------]  |  /    _)_
        |__________________________________ |/     /  /
    /-------------------------------------/|      ( )/
  /-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/ /
/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/ /
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
                                       "
                        start-sleep -seconds 10
                        clear #clears the console
                        
                        # $lockopen -eq "True"
                    } Else {
                        Write-Host -ForegroundColor Red "Error: Lock failed on opening.  Ask for help"
                        300..7000 | Get-Random -Count 35 | ForEach {[console]::Beep($_, 150)}
                    }
                } ElseIf ($Command -eq "Close") {
                    Write-Host -ForegroundColor Yellow "Warning: Lock already closed."
                } Else {
                    Write-Host -ForegroundColor Cyan "Lock status: Closed."
                }
            } Else {
                Write-Host -ForegroundColor Red "Error: $Method method not supported."
                Write-Host $HelpText
                Return
            }
        } Else {
            Write-Host -ForegroundColor Red "Error: Port $Port not open."
            Write-Host $HelpText
            Return
        }
    } ElseIf ($Devices -contains $Address) {
        If ($Port -eq $Ports[$CorrectPort]) {
            Write-Host -ForegroundColor Red "Error: Port $Port not open."
            Write-Host $HelpText
            Return
        } ElseIf ($Ports -contains $Port) {
            Write-Host -ForegroundColor Red "Error: No API found on port $Port."
            Write-Host $HelpText
            Return
        } Else {
            Write-Host -ForegroundColor Red "Error: Port $Port not open."
            Write-Host $HelpText
            Return
        }
    } Else {
        Write-Host -ForegroundColor Red "Error: Cannot connect to $Address on port $Port."
        Write-Host $HelpText
        Return
    }
}
# }
