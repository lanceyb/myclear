require 'test_helper'

class Myclear::ServiceTest < Minitest::Test

  def test_bank_list_enquiry
    response_body = "fpx_msgToken=01&fpx_sellerExId=EX00000000&fpx_bankList=PBB0233%7EA%2CMBB0228%7EA%2CBKRM0602%7EA%2CABMB0212%7EA%2CMB2U0227%7EA%2CBIMB0340%7EA%2CBMMB0341%7EB%2CKFH0346%7EA%2CABB0233%7EA%2CUOB0229%7EB%2CRHB0218%7EA%2COCBC0229%7EA%2CSCB0216%7EB%2CHLB0224%7EA%2CTEST0023%7EA%2CTEST0022%7EA%2CTEST0021%7EA%2CUOB0226%7EB%2CBCBB0235%7EA%2CLOAD001%7EA%2CAMBB0209%7EA%2CBSN0601%7EA%2CHSBC0223%7EA&fpx_checkSum=0655D97F647E6012C6B6FF03C13C55A2A55BDE00E882EDEBF63EFB8B365944E044DDB58CE1DCDAD48A808AA8058A6333A698961AAC6A2FBD0C7D0987030F164CE85525DCF9BEFF0191F5503FF9234C6487CBE4A9299A47472489BFB628591ED5695F2C726065BBAC520F1587357008B40FFE44FA64CF0F5A38035D2829D6D4DD6CB68B5DB57F36901F61D358D00F13ADB548088D5657ECF6E12B6773CBE1AD7CA02A923F5A3443D37F6DE87754AB04ABCF9FBE689869C460717C38EEBD78294ECE8F6B5A48FBB8AEB978D8075658563F700F3C083C23CB164DD2A06C8E3A3F77379AD914E83F3CB5A2EC8389EB5C08A40962A1972886A1BECC6D3616349B5F4D&fpx_msgType=BC"
    stub_request(
      :post,
      'https://uat.mepsfpx.com.my/FPXMain/RetrieveBankList'
    ).to_return(body: response_body)

    assert_equal response_body, Myclear::Service.bank_list_enquiry.body
  end

  def test_be_url
    assert_equal 'https://uat.mepsfpx.com.my/FPXMain/RetrieveBankList', Myclear::Service.be_url
    Myclear.uat = false
    assert_equal 'https://mepsfpx.com.my/FPXMain/RetrieveBankList', Myclear::Service.be_url
    Myclear.uat = true
  end

  def test_authorization_enquiry
    params = {
      'fpx_msgToken'        => '01',
      'fpx_sellerExOrderNo' => 'EXORDERNO0000',
      'fpx_sellerTxnTime'   => '20170817140102',
      'fpx_sellerOrderNo'   => 'ORDERNO000000',
      'fpx_txnCurrency'     => 'MYR',
      'fpx_txnAmount'       => '1.00',
      'fpx_buyerEmail'      => 'test@example.com',
      'fpx_buyerName'       => '',
      'fpx_buyerBankId'     => 'TEST0021',
      'fpx_buyerBankBranch' => 'SBI BANK A',
      'fpx_buyerAccNo'      => '',
      'fpx_buyerId'         => '',
      'fpx_makerName'       => '',
      'fpx_buyerIban'       => '',
      'fpx_productDesc'     => '1 goods'
    }
    response_body = 'fpx_debitAuthCode=00&fpx_debitAuthNo=&fpx_sellerExId=EX00000000&fpx_creditAuthNo=&fpx_buyerName=&fpx_buyerId=&fpx_sellerTxnTime=20170817140102&fpx_sellerExOrderNo=EXORDERNO0000&fpx_makerName=&fpx_buyerBankBranch=SBI+Bank+A&fpx_buyerBankId=TEST0021&fpx_msgToken=01&fpx_creditAuthCode=&fpx_sellerId=SE00000000&fpx_fpxTxnTime=&fpx_buyerIban=&fpx_sellerOrderNo=ORDERNO000000&fpx_txnAmount=1.00&fpx_fpxTxnId=&fpx_checkSum=8D8B1B04BCC6D8856E54C58841FC1747A3D9EBD364ABBD3E6FD020EFA3F11CA74AFA16DC5B8F0A76FBEA191EF59B90AAD697EE4425381148BE3E2DB3B1854CFEE14A471EFC9461B38283D07374D3EC573BC1FD4E3333180F83D8580FCC76DC7D67912B4AB299439E13D498A4E3EC3882D54D43B52DCECEA7C146795C9F59ADE9F7CFC733871D8504F90FC25C85842269EC5F777A2FE29EBED3B1EACEC884F1EEF287755CCEE2EFF6A2825DC7C8B444483F82FD89D49CAD797045344E92F9CD6222CA8149FE2010AA49C2731DD2708A7E3DA71E5D5B1B26280D91EA831A3DD2E81D8922AF7E8F5603CBB7F6CCA58B9151511A53449E0652D3E26C18FF13B18DE4&fpx_msgType=AC&fpx_txnCurrency=MYR'
    stub_request(
      :post,
      'https://uat.mepsfpx.com.my/FPXMain/sellerNVPTxnStatus.jsp'
    ).to_return(body: response_body)
    assert_equal response_body, Myclear::Service.authorization_enquiry(params).body.strip
  end

end
