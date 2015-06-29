# SphyGmo

gem 'gmo' (t-k/gmo-payment-ruby) をいい感じにwrapしたいなという観点のgemになります。
現状最低限自分で使っている機能しかwrapしていないので現状微妙です。

## Installation

Gemfileに以下の行を追加して、

```ruby
gem 'sphy_gmo', github: 'takumiabe/sphy_gmo', branch: 'master'
```

以下を実行する。

    $ bundle

または、手動でインストールする(specific_installを使う)

    $ gem install specific_install
    $ gem specific_install -l https://github.com/takumiabe/sphy_gmo.git

## Usage

### Configure

まず設定。GMOの契約情報を元に管理画面にアクセスし、APIキーを取得してくること。

アクセスキーを直にコードに書く場合は:

```ruby
SphyGmo.configure do |config|
  config.host = 'gmo-server-domain-name.com'
  config.site_id = 'tsite00000000'
  config.site_pass = 'abcd1234'
  config.shop_id = 'tshop00000000'
  config.shop_pass = 'abcd1234'
end
```

認証情報を直接コミットしたくない場合は、環境変数に噛ませる等する:

```ruby
SphyGmo.configure do |config|
  config.host = ENV['GMO_HOST']
  config.site_id = ENV['GMO_SITE_ID']
  config.site_pass = ENV['GMO_SITE_PASS']
  config.shop_id = ENV['GMO_SHOP_ID']
  config.shop_pass = ENV['GMO_SHOP_PASS]
end
```

### Query

使用方法の理解にはGMOの仕様PDFを通読することは必須。
See `030_プロトコルタイプ（カード決済_インタフェース仕様）_*.*.pdf`

API名からメソッドへのマップは基本的に以下のルール

  /payment/SearchMember/ to SphyGmo::Member.search!
  /payment/EntryTran/ to SphyGmo::Transaction.entry!
  ...

引数はスネークケースで、ハッシュで渡すこと。
```ruby
SphyGmo::Member.search!(member_id: ... )
```


## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release` to create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

1. Fork it ( https://github.com/takumiabe/sphy_gmo/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
