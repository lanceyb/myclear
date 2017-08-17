# Myclear

A unofficial myclear ruby gem.

Myclear official document: https://fpxexchange.myclear.org.my:8443/MerchantIntegrationKit/

note: Myclear的官方文档需要密码才能查看，请自行向 Myclear 申请.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'myclear'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install myclear

## Configuration

```ruby
Myclear.fpx_version = '7.0'
Myclear.seller_exchange_id = 'YOUR SELLER EXCHANGE ID'
Myclear.seller_id = 'YOUR SELLER ID'
Myclear.private_key = 'YOUR RSA PRIVATE KEY'
Myclear.fpx_certification = 'THE FPX CERTIFICATION'

# Myclear.debug_mode = true # Enable parameter check. Default is true.
# Myclear.fpx_standby_certification = 'THE STANDBY FPX CERTIFICATIO
```

eg: 

```ruby
if Rails.env.production?
  Myclear.fpx_version = '7.0'
  Myclear.seller_exchange_id = 'YOUR SELLER EXCHANGE ID'
  Myclear.seller_id = 'YOUR SELLER ID'
  Myclear.private_key = 'YOUR RSA PRIVATE KEY'
  Myclear.fpx_certification = 'THE FPX CERTIFICATION'
else
  Myclear.fpx_version = '7.0'
  Myclear.seller_exchange_id = 'EX00000000'
  Myclear.seller_id = 'SE00000000'
  Myclear.private_key = File.read(File.expand_path('./EX00000000.key', Rails.root))
  Myclear.fpx_certification = File.read(File.expand_path('./fpxuat.cer', Rails.root))
end
```

## Service

### bank list（银行列表）

```ruby
Myclear::Service.bank_list_enquiry
```

### Authorization Request（申请支付）

```ruby
Myclear::Service.authorization_request_params({ARGUMENTS})
```

#### Example
```ruby
Myclear::Service.authorization_request_params({
  fpx_msgToken:         '01',
  fpx_sellerExOrderNo:  'EXORDERNO0000',
  fpx_sellerTxnTime:    '20170817140102',
  fpx_sellerOrderNo:    'ORDERNO000000',
  fpx_txnCurrency:      'MYR',
  fpx_txnAmount:        '1.00',
  fpx_buyerEmail:       'test@example.com',
  fpx_buyerName:        '',
  fpx_buyerBankId:      'TEST0021',
  fpx_buyerBankBranch:  'SBI BANK A',
  fpx_buyerAccNo:       '',
  fpx_buyerId:          '',
  fpx_makerName:        '',
  fpx_buyerIban:        '',
  fpx_productDesc:      '1 goods'
})
```

#### Arugments



### Authorization Enquiry 

```ruby
Myclear::Service.authorization_enquiry({ARGUMENTS})
```

#### Example
```ruby
Myclear::Service.authorization_enquiry({

})
```

#### Arugments


## Contributing

Bug reports and pull requests are welcome.

### Make a pull request

1. Fork it
2. Create your feature branch (git checkout -b my-new-feature)
3. Commit your changes (git commit -am 'Add some feature')
4. Push to the branch (git push origin my-new-feature)
5. Create new Pull Request

Please write unit test with your code if necessary.
