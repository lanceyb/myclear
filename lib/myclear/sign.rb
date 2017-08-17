module Myclear
  module Sign
    def self.generate(str, options = {})
      key = OpenSSL::PKey::RSA.new(Myclear.private_key)
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
      Myclear::Utils.binary_to_hex(key.sign(digest, str))
    end

    def self.verify?(sign, str, options = {})
      cer = OpenSSL::X509::Certificate.new(Myclear.fpx_certification)
      if(cer.not_after < Time.now && !Myclear.fpx_standby_certification.nil?)
        warn("Myclear Warn: the main certification has expired, please replace a new one.") if !Myclear.debug_mode?
        cer = Myclear.fpx_standby_certification
      end
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
      cer.public_key.verify(digest, Myclear::Utils.hex_to_binary(sign), str)
    end
  end
end
