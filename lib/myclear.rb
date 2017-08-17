require "myclear/version"
require "myclear/sign"
require "myclear/utils"
require "myclear/service"
require 'openssl'

module Myclear
  @debug_mode = true
  @digest_type = 'SHA1'
  @fpx_version = '7.0'
  @uat = true

  class << self
    attr_accessor :debug_mode, :uat
    attr_accessor :digest_type, :fpx_version
    attr_accessor :private_key, :fpx_certification, :fpx_standby_certification
    attr_accessor :seller_exchange_id, :seller_id

    def debug_mode?
      !!@debug_mode
    end

    def uat?
      !!@uat
    end

    def service_host
      uat? ? 'https://uat.mepsfpx.com.my' : 'https://mepsfpx.com.my'
    end
  end
end
