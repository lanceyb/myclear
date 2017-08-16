require 'test_helper'

class Myclear::UtilsTest < Minitest::Test
  def test_stringify_keys
    hash = { 'a' => 1, :b => 2 }
    assert_equal({ 'a' => 1, 'b' => 2 }.sort, Myclear::Utils.stringify_keys(hash).sort)
  end
end
