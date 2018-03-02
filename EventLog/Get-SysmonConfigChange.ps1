
function Get-SysmonConfigChange {
    <#
    .SYNOPSIS
        Get Sysmon configuration change events (EventId 16).
    .DESCRIPTION
        Get Sysmon configuration change events either locally or remotely from a specified location.
        These events have an EventID of 16 and are for when a configuration is updated or cleared using
        the sysmon.exe tool.
    .EXAMPLE
        PS C:\> Get-SysmonConfigChange -ConfigurationFileHash ''
        Get events with a empty configuration file hash field. This may be due to a configuration being modified or cleared via the command line.
    .INPUTS
        System.IO.FileInfo
    .OUTPUTS
        Sysmon.EventRecord.ConfigChange
    #>
    [CmdletBinding(DefaultParameterSetName = 'Local')]
    param (
        # Log name for where the events are stored.
        [Parameter(Mandatory = $false,
                   ValueFromPipelineByPropertyName = $true)]
        [string]
        $LogName = 'Microsoft-Windows-Sysmon/Operational',

        # Full path of XML file used for configuration, current folder of the process and full command line of execution for configuration or
        # currentlocation with the word Default at the end of the path in case the configuration was reset to default values.
        [Parameter(Mandatory = $false,
                   ValueFromPipelineByPropertyName = $true)]
        [string[]]
        $Configuration,

        # File hash for the configuration file used to configure Sysmon.
        [Parameter(Mandatory = $false,
                   ValueFromPipelineByPropertyName = $true)]
        [string[]]
        $ConfigurationFileHash,

        # Specifies the path to the event log files that this cmdlet get events from. Enter the paths to the log files in a comma-separated list, or use wildcard characters to create file path patterns. Function supports files with the .evtx file name extension. You can include events from different files and file types in the same command.
        [Parameter(Mandatory=$true,
                   Position=0,
                   ParameterSetName="file",
                   ValueFromPipelineByPropertyName=$true)]
        [Alias("FullName")]
        [ValidateNotNullOrEmpty()]
        [SupportsWildcards()]
        [string[]]
        $Path,


        # Gets events from the event logs on the specified computer. Type the NetBIOS name, an Internet Protocol (IP) address, or the fully qualified domain name of the computer.
        # The default value is the local computer.
        # To get events and event logs from remote computers, the firewall port for the event log service must be configured to allow remote access.
        [Parameter(Mandatory = $true,
                   ValueFromPipelineByPropertyName = $true,
                   ParameterSetName = 'Remote')]
        [string[]]
        $ComputerName,

        # Specifies a user account that has permission to perform this action.
        #
        # Type a user name, such as User01 or Domain01\User01. Or, enter a PSCredential object, such as one generated by the Get-Credential cmdlet. If you type a user name, you will
        # be prompted for a password. If you type only the parameter name, you will be prompted for both a user name and a password.
        [Parameter(Mandatory = $false,
                   ParameterSetName = 'Remote')]
        [Management.Automation.PSCredential]
        [Management.Automation.CredentialAttribute()]
        $Credential,

        # Specifies the maximum number of events that are returned. Enter an integer. The default is to return all the events in the logs or files.
        [Parameter(Mandatory = $false,
                   ValueFromPipelineByPropertyName = $true)]
        [int64]
        $MaxEvents,

        # Stsrttime from where to pull events.
        [Parameter(Mandatory = $false)]
        [datetime]
        $StartTime,

        # Stsrttime from where to pull events.
        [Parameter(Mandatory = $false)]
        [datetime]
        $EndTime,

        # Changes the default logic for matching fields from 'and' to 'or'.
        [Parameter(Mandatory = $false)]
        [switch]
        $ChangeLogic
    )

    begin {}

    process {
        Search-SysmonEvent -EventId 16 -ParamHash $MyInvocation.BoundParameters

    }

    end {}
}