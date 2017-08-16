require 'test_helper'

class Myclear::UtilsTest < Minitest::Test

  def setup
    @str = '1|a|2|b'
    @hex_str = '317C617C327C62'
  end

  def test_stringify_keys
    hash = { 'a' => 1, :b => 2 }
    assert_equal({ 'a' => 1, 'b' => 2 }.sort, Myclear::Utils.stringify_keys(hash).sort)
  end

  def test_binary_to_hex
    assert_equal @hex_str, Myclear::Utils.binary_to_hex(@str)
  end

  def test_hex_to_binary
    assert_equal @str, Myclear::Utils.hex_to_binary(@hex_str)
  end
end
