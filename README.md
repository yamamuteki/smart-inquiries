# README [![Build Status](https://travis-ci.org/yamamuteki/smart-inquiries.svg?branch=master)](https://travis-ci.org/yamamuteki/smart-inquiries) [![Coverage Status](https://coveralls.io/repos/github/yamamuteki/smart-inquiries/badge.svg?branch=master)](https://coveralls.io/github/yamamuteki/smart-inquiries?branch=master)

##インストール方法

Windowsの場合は下記ページからRubyとDevKitをインストールしてください。

（Windows環境ではgemの互換性から2.1系最新をお勧めします。）

[http://rubyinstaller.org/downloads/](http://rubyinstaller.org/downloads/)

```ruby
gem install bundler
git clone https://github.com/yamamuteki/smart-inquiries.git
cd smart-inquiries
bundle install --without production
rake db:migrate
rails s
```

ブラウザで以下のアドレスにアクセスしてください。

[http://localhost:3000/](http://localhost:3000/)

※ development 環境だとメールは tmp/mail に出力されます。
