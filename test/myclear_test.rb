require "test_helper"

class MyclearTest < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::Myclear::VERSION
  end

  def test_debug_mode_default
    assert Myclear.debug_mode?
  end

  def test_digest_type_default
    assert_equal 'SHA1', Myclear.digest_type
  end

  def test_fpx_version_default
    assert_equal '7.0', Myclear.fpx_version
  end

  def test_uat_default
    assert Myclear.uat?
  end

  def test_service_host
    assert_equal 'https://uat.mepsfpx.com.my', Myclear.service_host
    Myclear.uat = false
    assert_equal 'https://mepsfpx.com.my', Myclear.service_host
    Myclear.uat = true
  end

end
