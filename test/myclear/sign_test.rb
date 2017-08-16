require 'test_helper'

class Myclear::SignTest < Minitest::Test
  def setup
    @str = '1|a|2|b'
    @hex_str = '317C617C327C62'
    @sha1_sign = ''
  end

  def test_generate_sign
    # [TODO]
    Myclear::Sign.generate(@str)
    assert true
  end

end
