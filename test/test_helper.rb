$LOAD_PATH.unshift File.expand_path("../../lib", __FILE__)
require "myclear"

require "minitest/autorun"

Myclear.fpx_version = '7.0'
# Myclear.seller_exchange_id = 'EX00006370'
# Myclear.seller_id = 'SE00007438'
# Myclear.service_host = 'https://uat.mepsfpx.com.my'
# Myclear.primary_key = File.read(File.expand_path('./../../test/files/EX00006370.key', __FILE__))
# Myclear.fpx_certification = File.read(File.expand_path('./../../test/files/fpxuat.cer', __FILE__))
