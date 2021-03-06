# Author : ArifAsyraf && Eashan
# Date   : 26th March 2018
# Info   : Clear browser and Microsoft cache files


# Declaring logfile troublesooting purposes
$Logfile = "Put log path here (e.g: D:\ClearCache\result.log)"
Function LogWrite
{
   Param ([string]$logstring)

   Add-content $Logfile -value $logstring
}

# List the users in c:\users and export to the local profile for calling
dir C:\Users | select Name | Export-Csv -Path "Put your destination path here" -NoTypeInformation
$list=Test-Path "Put target path here (e.g: C:\users\$env:USERNAME\names.csv)


if ($list) {
    # Clear Mozilla Firefox Cache
     Import-CSV -Path C:\users\$env:USERNAME\names.csv -Header Name | foreach {
            Remove-Item -path C:\Users\$($_.Name)\AppData\Local\Mozilla\Firefox\Profiles\*.default\cache\* -Recurse -Force -EA SilentlyContinue -Verbose
            Remove-Item -path C:\Users\$($_.Name)\AppData\Local\Mozilla\Firefox\Profiles\*.default\cache\*.* -Recurse -Force -EA SilentlyContinue -Verbose
	        Remove-Item -path C:\Users\$($_.Name)\AppData\Local\Mozilla\Firefox\Profiles\*.default\cache2\entries\*.* -Recurse -Force -EA SilentlyContinue -Verbose
            Remove-Item -path C:\Users\$($_.Name)\AppData\Local\Mozilla\Firefox\Profiles\*.default\thumbnails\* -Recurse -Force -EA SilentlyContinue -Verbose
            Remove-Item -path C:\Users\$($_.Name)\AppData\Local\Mozilla\Firefox\Profiles\*.default\cookies.sqlite -Recurse -Force -EA SilentlyContinue -Verbose
            Remove-Item -path C:\Users\$($_.Name)\AppData\Local\Mozilla\Firefox\Profiles\*.default\webappsstore.sqlite -Recurse -Force -EA SilentlyContinue -Verbose
            Remove-Item -path C:\Users\$($_.Name)\AppData\Local\Mozilla\Firefox\Profiles\*.default\chromeappsstore.sqlite -Recurse -Force -EA SilentlyContinue -Verbose
            Logwrite "Performing operation 'Remove File' on Target '$($_.Name)' Mozilla Firefox cache files"
            }
   
    # Clear Google Chrome Cache
     Import-CSV -Path C:\users\$env:USERNAME\names.csv -Header Name | foreach {
            Remove-Item -path "C:\Users\$($_.Name)\AppData\Local\Google\Chrome\User Data\Default\Cache\*" -Recurse -Force -EA SilentlyContinue -Verbose
            Remove-Item -path "C:\Users\$($_.Name)\AppData\Local\Google\Chrome\User Data\Default\Cache2\entries\*" -Recurse -Force -EA SilentlyContinue -Verbose
            Remove-Item -path "C:\Users\$($_.Name)\AppData\Local\Google\Chrome\User Data\Default\Cookies" -Recurse -Force -EA SilentlyContinue -Verbose
            Remove-Item -path "C:\Users\$($_.Name)\AppData\Local\Google\Chrome\User Data\Default\Media Cache" -Recurse -Force -EA SilentlyContinue -Verbose
            Remove-Item -path "C:\Users\$($_.Name)\AppData\Local\Google\Chrome\User Data\Default\Cookies-Journal" -Recurse -Force -EA SilentlyContinue -Verbose
            Logwrite "Performing operation 'Remove File' on Target '$($_.Name)' Google Chrome cache files"
            # Comment out the following line to remove the Chrome Write Font Cache too.
            # Remove-Item -path "C:\Users\$($_.Name)\AppData\Local\Google\Chrome\User Data\Default\ChromeDWriteFontCache" -Recurse -Force -EA SilentlyContinue -Verbose
            }

   # Clear Internet Explorer Cache
    Import-CSV -Path C:\users\$env:USERNAME\names.csv | foreach {
       Remove-Item -path "C:\Users\$($_.Name)\AppData\Local\Microsoft\Windows\Temporary Internet Files\*" -Recurse -Force -EA SilentlyContinue -Verbose 
       Remove-Item -path "C:\Users\$($_.Name)\AppData\Local\Microsoft\Windows\WER\*" -Recurse -Force -EA SilentlyContinue -Verbose 
       Remove-Item -path "C:\Users\$($_.Name)\AppData\Local\Temp\*" -Recurse -Force -EA SilentlyContinue -Verbose 
       Remove-Item -path "C:\Windows\Temp\*" -Recurse -Force -EA SilentlyContinue -Verbose 
       Remove-Item -path "C:\`$recycle.bin\" -Recurse -Force -EA SilentlyContinue -Verbose 
       Logwrite "Performing operation 'Remove File' on Target '$($_.Name)' Internet Explorer cache files"
            }
    
    # Clear Microsoft Terminal Cache
    Import-CSV -Path C:\users\$env:USERNAME\names.csv -Header Name | foreach {            
            Remove-Item -path "C:\Users\$($_.Name)\AppData\Local\Microsoft\Terminal Server Client\Cache\*.bin" -Recurse -Force -EA SilentlyContinue -Verbose
            Logwrite "Performing operation 'Remove File' on Target '$($_.Name)' cache files at 'C:\Users\$($_.Name)\AppData\Local\Microsoft\Terminal Server Client\Cache\*.bin'"
            }        

    } else {	
	Exit
	}