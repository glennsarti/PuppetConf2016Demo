@ECHO OFF

robocopy "%~dp0" "C:\Demo\Source" /s /e /copy:dat /mir /xd ".git" "modules" "tmp"