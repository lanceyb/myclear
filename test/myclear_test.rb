require "test_helper"

class MyclearTest < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::Myclear::VERSION
  end

  def test_debug_mode_default
    assert Myclear.debug_mode?
  end

  def test_sign_type_default
    assert_equal 'sha1', Myclear.sign_type
  end
end
