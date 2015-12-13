@echo off

set RUBY_HOME=D:\home\site\wwwroot\bin\ruby\%RUBY_VERSION%
set PATH=%RUBY_HOME%\devkit\mingw\bin;%PATH%

%RUBY_HOME%\bin\ruby.exe %RUBY_HOME%\bin\thin -e %RUBY_ENV% -p %HTTP_PLATFORM_PORT% -c '%RAILS_ROOT%' start