require "myclear/version"

module Myclear
  @debug_mode = true
  @sign_type = 'sha1'
  @fpx_version = '7.0'

  class << self
    attr_accessor :debug_mode, :sign_type, :fpx_version
    attr_accessor :fpx_certification, :fpx_after_certification, :primary_key,
      :seller_exchange_id, :seller_id, :service_host, :fpx_version

    def debug_mode?
      !!@debug_mode
    end
  end

  module Service
    # BE
    BE_URI = '/FPXMain/RetrieveBankList'
    def self.bank_list_enquiry options = {}
      params = {
        'fpx_msgType' => 'BE',
        'fpx_msgToken' => '01',
        'fpx_sellerExId' => Myclear.seller_exchange_id,
        'fpx_version' => Myclear.fpx_version
      }

      request(BE_URI, params, options)
    end

    def self.be_url
      Myclear.service_host + BE_URI
    end

    # AR
    # fpx_msgToken: B2C => '01',  B2B => '02'
    AR_URI = '/FPXMain/seller2DReceiver.jsp'
    AR_REQUIRED_PARAMS = %w(fpx_msgToken fpx_sellerExOrderNo fpx_sellerTxnTime fpx_sellerOrderNo fpx_txnCurrency fpx_txnAmount fpx_buyerEmail fpx_buyerName fpx_buyerBankId fpx_buyerBankBranch fpx_buyerAccNo fpx_buyerId fpx_makerName fpx_buyerIban fpx_productDesc)
    def self.authorization_request(params, options = {})
      params = Utils.stringify_keys(params)
      check_params(params, AR_REQUIRED_PARAMS)
      params = {
        'fpx_msgType' => 'AR',
        'fpx_sellerBankCode' => '01',
        'fpx_sellerExId' => Myclear.seller_exchange_id,
        'fpx_version' => Myclear.fpx_version,
        'fpx_sellerId' => Myclear.seller_id
      }.merge(params)

      # request_uri(params, options)
      sign_params(params, options)
    end

    def self.ar_url
      Myclear.service_host + AR_URI
    end

    # AE
    # fpx_msgToken: B2C => '01',  B2B => '02'
    AE_URI = '/FPXMain/sellerNVPTxnStatus.jsp'
    AE_REQUIRED_PARAMS = %w(fpx_msgToken fpx_sellerExOrderNo fpx_sellerTxnTime fpx_sellerOrderNo fpx_txnCurrency fpx_txnAmount fpx_buyerEmail fpx_buyerName fpx_buyerBankId fpx_buyerBankBranch fpx_buyerAccNo fpx_buyerId fpx_makerName fpx_buyerIban fpx_productDesc)
    def self.authorization_enquiry(params, options = {})
      params = Utils.stringify_keys(params)
      check_params(params, AE_REQUIRED_PARAMS)
      params = {
        'fpx_msgType' => 'AE',
        'fpx_sellerBankCode' => '01',
        'fpx_sellerExId' => Myclear.seller_exchange_id,
        'fpx_version' => Myclear.fpx_version,
        'fpx_sellerId' => Myclear.seller_id
      }.merge(params)

      request(AE_URI, params, options)
    end

    def self.ae_url
      Myclear.service_host + AR_URI
    end

    VERIFY_REQUIRED_PARAMS = %w(fpx_buyerBankBranch fpx_buyerBankId fpx_buyerIban fpx_buyerId fpx_buyerName fpx_creditAuthCode fpx_creditAuthNo fpx_debitAuthCode fpx_debitAuthNo fpx_fpxTxnId fpx_fpxTxnTime fpx_makerName fpx_msgToken fpx_msgType fpx_sellerExId fpx_sellerExOrderNo fpx_sellerId fpx_sellerOrderNo fpx_sellerTxnTime fpx_txnAmount fpx_txnCurrency fpx_checkSum)
    def self.verify_params(params, options = {})
      params = Utils.stringify_keys(params)
      check_params(params, VERIFY_REQUIRED_PARAMS)
      Myclear::Sign.verify?(params.delete('fpx_checkSum'), package_params(params))
    end

    def self.request_uri(params, options = {})
      uri = URI(GATEWAY_URL)
      uri.query = URI.encode_www_form(sign_params(params, options))
      uri
    end

    def self.request(uri, params, options = {})
      host_uri = URI(Myclear.service_host)
      http = Net::HTTP.new(host_uri.host, host_uri.port)
      http.use_ssl = true
      http.verify_mode = OpenSSL::SSL::VERIFY_NONE
      req = Net::HTTP::Post.new(uri)
      req.set_form_data(sign_params(params, options))
      http.request(req)
    end

    def self.sign_params(params, options)
      params.merge(
        'fpx_checkSum' => Myclear::Sign.generate(package_params(params), options)
      ) 
    end

    def self.package_params(params)
      params.sort_by { |key, value| key }.to_h.values.join("|")
    end

    def self.check_params(params, names)
      return if !Myclear.debug_mode?

      (params.keys - names).each { |key| warn("Myclear Warn: unknown option: #{key}") }

      names.each do |name|
        warn("Myclear Warn: missing required option: #{name}") unless params.has_key?(name)
      end
    end

  end

  module Sign
    def self.generate(str, options = {})
      key = OpenSSL::PKey::RSA.new(Myclear.primary_key)
      bin_to_hex(key.sign(OpenSSL::Digest::SHA1.new, str))
    end

    def self.verify?(sign, str)
      cer = OpenSSL::X509::Certificate.new(Myclear.fpx_certification)
      digest = OpenSSL::Digest::SHA1.new
      cer.public_key.verify(digest, hex_to_bin(sign), str)
    end

    def self.bin_to_hex(str)
      str.unpack("H*").first.upcase
    end

    def self.hex_to_bin(str)
      [str.downcase].pack("H*")
    end
  end

  module Utils
    def self.stringify_keys(hash)
      new_hash = {}
      hash.each do |key, value|
        new_hash[(key.to_s rescue key) || key] = value
      end
      new_hash
    end
  end
end
