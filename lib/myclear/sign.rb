module Myclear
  module Sign
    def self.generate(str, options = {})
      key = OpenSSL::PKey::RSA.new(Myclear.primary_key)
      digest_type = options[:digest_type] || Myclear.digest_type
      digest = case digest_type
               when 'SHA1'
                 OpenSSL::Digest::SHA1.new
               when 'SHA256'
                 OpenSSL::Digest::SHA256.new
               when 'SHA512'
                 OpenSSL::Digest::SHA512.new
               else
                 raise ArgumentError, "invalid digest_type #{digest_type}, allow value: 'SHA1', 'SHA256', 'SHA512'"
               end
      bin_to_hex(key.sign(digest, str))
    end

    def self.verify?(sign, str, options = {})
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
end
