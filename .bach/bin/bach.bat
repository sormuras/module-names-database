@ECHO OFF

IF "%~1" == "boot" (
  jshell --module-path .bach\bin --add-modules com.github.sormuras.bach .bach\bin\boot.jsh
  EXIT /B %ERRORLEVEL%
)

IF "%~1" == "init" (
  IF "%~2" == "" (
    ECHO "Usage: bach init VERSION"
    EXIT /B 1
  )
  java .bach\bin\Init.java %2
  EXIT /B %ERRORLEVEL%
)

java --module-path .bach\bin --module com.github.sormuras.bach %*
EXIT /B %ERRORLEVEL%
