set src=%appdata%\Mozilla\Firefox\Profiles\bgptm3hc.default-release\bookmarkbackups
set dest= %userprofile%\Documents\Sync\Backups\WebBookmarks

robocopy %src% %dest% /MIR
