oh-my-posh init pwsh --config 'C:\Users\ACER\AppData\Local\Programs\oh-my-posh\themes\powerlevel10k_modern.json' | Invoke-Expression

Import-Module -Name Terminal-Icons
Import-Module PSReadLine

Set-PSReadLineOption -PredictionSource History
Set-PSReadLineOption -PredictionViewStyle ListView

function lute {
    cd C:\my_lute
    myenv/Scripts/activate
    python -m lute.main
}


function ibda2032 {
    cd C:\Users\ACER\Desktop\IBDA2032
    venv/Scripts/activate
}


# Sometimes you enter a command but realize you forgot to do something else first.
# This binding will let you save that command in the history so you can recall it,
# but it doesn't actually execute.  It also clears the line with RevertLine so the
# undo stack is reset - though redo will still reconstruct the command line.
Set-PSReadLineKeyHandler -Key Alt+w `
                         -BriefDescription SaveInHistory `
                         -LongDescription "Save current line in history but do not execute" `
                         -ScriptBlock {
    param($key, $arg)

    $line = $null
    $cursor = $null
    [Microsoft.PowerShell.PSConsoleReadLine]::GetBufferState([ref]$line, [ref]$cursor)
    [Microsoft.PowerShell.PSConsoleReadLine]::AddToHistory($line)
    [Microsoft.PowerShell.PSConsoleReadLine]::RevertLine()
}

# # F1 for help on the command line - naturally
# Set-PSReadLineKeyHandler -Key F1 `
#                          -BriefDescription CommandHelp `
#                          -LongDescription "Open the help window for the current command" `
#                          -ScriptBlock {
#     param($key, $arg)

#     $ast = $null
#     $tokens = $null
#     $errors = $null
#     $cursor = $null
#     [Microsoft.PowerShell.PSConsoleReadLine]::GetBufferState([ref]$ast, [ref]$tokens, [ref]$errors, [ref]$cursor)

#     $commandAst = $ast.FindAll( {
#         $node = $args[0]
#         $node -is [CommandAst] -and
#             $node.Extent.StartOffset -le $cursor -and
#             $node.Extent.EndOffset -ge $cursor
#         }, $true) | Select-Object -Last 1

#     if ($commandAst -ne $null)
#     {
#         $commandName = $commandAst.GetCommandName()
#         if ($commandName -ne $null)
#         {
#             $command = $ExecutionContext.InvokeCommand.GetCommand($commandName, 'All')
#             if ($command -is [AliasInfo])
#             {
#                 $commandName = $command.ResolvedCommandName
#             }

#             if ($commandName -ne $null)
#             {
#                 Get-Help $commandName -ShowWindow
#             }
#         }
#     }
# }
# Import the Chocolatey Profile that contains the necessary code to enable
# tab-completions to function for `choco`.
# Be aware that if you are missing these lines from your profile, tab completion
# for `choco` will not function.
# See https://ch0.co/tab-completion for details.
$ChocolateyProfile = "$env:ChocolateyInstall\helpers\chocolateyProfile.psm1"
if (Test-Path($ChocolateyProfile)) {
  Import-Module "$ChocolateyProfile"
}
