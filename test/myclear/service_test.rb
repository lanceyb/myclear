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

  def test_ae_url
    assert_equal 'https://uat.mepsfpx.com.my/FPXMain/sellerNVPTxnStatus.jsp', Myclear::Service.ae_url
    Myclear.uat = false
    assert_equal 'https://mepsfpx.com.my/FPXMain/sellerNVPTxnStatus.jsp', Myclear::Service.ae_url
    Myclear.uat = true
  end

  def test_ar_url
    assert_equal 'https://uat.mepsfpx.com.my/FPXMain/seller2DReceiver.jsp', Myclear::Service.ar_url
    Myclear.uat = false
    assert_equal 'https://mepsfpx.com.my/FPXMain/seller2DReceiver.jsp', Myclear::Service.ar_url
    Myclear.uat = true
  end

  def test_authorization_request_params
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
    request_params = {
      "fpx_msgType"=>"AR",
      "fpx_sellerBankCode"=>"01",
      "fpx_sellerExId"=>"EX00000000",
      "fpx_version"=>"7.0",
      "fpx_sellerId"=>"SE00000000",
      "fpx_msgToken"=>"01",
      "fpx_sellerExOrderNo"=>"EXORDERNO0000",
      "fpx_sellerTxnTime"=>"20170817140102",
      "fpx_sellerOrderNo"=>"ORDERNO000000",
      "fpx_txnCurrency"=>"MYR",
      "fpx_txnAmount"=>"1.00",
      "fpx_buyerEmail"=>"test@example.com",
      "fpx_buyerName"=>"",
      "fpx_buyerBankId"=>"TEST0021",
      "fpx_buyerBankBranch"=>"SBI BANK A",
      "fpx_buyerAccNo"=>"",
      "fpx_buyerId"=>"",
      "fpx_makerName"=>"",
      "fpx_buyerIban"=>"",
      "fpx_productDesc"=>"1 goods",
      "fpx_checkSum"=> "5BB0DBFBC886C017503CEA1FF456381D0062C5845B40F7990169157CBEBA52CFD7E6720021C450F4110E4C282509D5A0B13372724B86C96CA46076416BE169EC69454529FB4BD773133FE951DE139FAE87AC2560FFE11AC43491228A28BD15E78E4FF1797EFCD86697D6B96410B5335CDABB0D488B23F86E0DA4DD0FF6D7B87B472AEF4E0FFC25E5565F986E8FB4658AFA09F2F1CC20DB20B31794F317E0188A0C2C59B820263689CE5561933583A58054E0ADB0F36AFD5D6D62692E110850690D997DE448213CE31E9DF5FC4A305AAA830AE46EAC89F150482838AA2ED6FB921A9440890FAB9C78EB0E7477589FE76D209680BD12F3A99943648CBF7488E2DC"
    }
    assert_equal request_params.sort, Myclear::Service.authorization_request_params(params).sort
  end

  def test_verify_params
    params = {
      'fpx_creditAuthCode'  => '00',
      "fpx_msgType"         => 'AC',
      'fpx_msgToken'        => '01',
      'fpx_sellerExOrderNo' => 'EXORDERNO0000',
      'fpx_sellerTxnTime'   => '20170817140102',
      "fpx_sellerExId"      => 'EX00000000',
      "fpx_sellerId"        => "SE00007438",
      'fpx_sellerOrderNo'   => 'ORDERNO000000',
      'fpx_txnCurrency'     => 'MYR',
      'fpx_txnAmount'       => '1.00',
      "fpx_buyerName"       => "Nur@/() .-_,&'Ain",
      'fpx_buyerBankId'     => 'TEST0021',
      'fpx_buyerBankBranch' => 'SBI BANK A',
      'fpx_buyerId'         => 'Buyer1234',
      'fpx_buyerIban'       => '',
      'fpx_creditAuthNo'    => '9999999999',
      "fpx_debitAuthCode"   => "00",
      "fpx_debitAuthNo"     => "15733223",
      'fpx_fpxTxnId'        => '1707051119360697',
      "fpx_makerName"       => "Nik'Nur",
      "fpx_fpxTxnTime"      => "20170705112840",
      'fpx_checkSum'        => '3BBB3E7163F7937ACB1800D349E6CB12EB9200FA0505AB92EF4F9BC6322A2E366331E9B335EE72C511B8001B89DFC16B70D11641633B48865D400BC1A28B168E789C9C5A3A4BA940379D55F89EBF1CCC54C069D6F2B592D451B5E12B1F41F222EAB76221AFFFE5B6382AFBDAF7E8843F2A92BAAFB9D9B0A019B1F27D03AD34A1809D0E6A7EF366EFF156172D1BD1EC95528A084FED20E10440D0A393399C7DECF7485D5325372F40EFF47B614274C05E88102E272B183EEA9D8590EB4AAAC0489B7246EEDD87DCE0B6B1A9BA5378C35EF85A45AEC7D22719882C2A0CD7B0C52493A2D59E935E8CF50159C21143D1F90528E65C6230DDDA835EB9672E70E08D79'
    }

    assert Myclear::Service.verify_params(params)
  end

end
