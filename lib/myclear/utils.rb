module Myclear
  module Utils
    def self.stringify_keys(hash)
      new_hash = {}
      hash.each do |key, value|
        new_hash[(key.to_s rescue key) || key] = value
      end
      new_hash
    end

    def self.binary_to_hex(str)
      str.unpack("H*").first.upcase
    end

    def self.hex_to_binary(str)
      [str.downcase].pack("H*")
    end
  end
end
