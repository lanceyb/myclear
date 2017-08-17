$LOAD_PATH.unshift File.expand_path("../../lib", __FILE__)
require "myclear"
require "minitest/autorun"
require 'webmock/minitest'

TEST_RSA_CERTIFICATE = <<EOF
-----BEGIN CERTIFICATE-----
MIIDtTCCAp2gAwIBAgIJALvCyLy7sGlKMA0GCSqGSIb3DQEBBQUAMEUxCzAJBgNV
BAYTAkFVMRMwEQYDVQQIEwpTb21lLVN0YXRlMSEwHwYDVQQKExhJbnRlcm5ldCBX
aWRnaXRzIFB0eSBMdGQwHhcNMTcwODE3MDI1MDIyWhcNMjcwODE1MDI1MDIyWjBF
MQswCQYDVQQGEwJBVTETMBEGA1UECBMKU29tZS1TdGF0ZTEhMB8GA1UEChMYSW50
ZXJuZXQgV2lkZ2l0cyBQdHkgTHRkMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIB
CgKCAQEAymY3MxGyBA1VsXIonOaUUMDQjJUIyI7ZmoUhwdwIMju379MNS1VNV3AE
z4o2jze5jUSdPun+O84CnZWb+oREbhqIIyzjk1JJ6/8daGaW9dXBdvNcRc8i+Nsl
3mQFxboGUwcYflVXY3Deh3DSuwNx8qfVjvipsTceMBHYbIaeDR4X2zpFfRp9gCfQ
wS3a1b8RnFIfd/Q3ffj9byxFpDwd5xnVIMJwzSJmcnGYA5AKGW+Ey+q980Vt6q4T
j0jB/01db/dlzPbZ9ejAInZIjjhD1zu8d+TMDPO2gTMV2Y8XlTkl4Tr4BhSfKYQG
1e1Vv0lgt+FNkpTmKx352RyKOiz1OwIDAQABo4GnMIGkMB0GA1UdDgQWBBSNV46C
0E6XaFdhLUZlgLlwjkzPYTB1BgNVHSMEbjBsgBSNV46C0E6XaFdhLUZlgLlwjkzP
YaFJpEcwRTELMAkGA1UEBhMCQVUxEzARBgNVBAgTClNvbWUtU3RhdGUxITAfBgNV
BAoTGEludGVybmV0IFdpZGdpdHMgUHR5IEx0ZIIJALvCyLy7sGlKMAwGA1UdEwQF
MAMBAf8wDQYJKoZIhvcNAQEFBQADggEBAJq75ALNutyk8HPs5z/wf8vTr5B6ePj0
svuf9VEHlLpFxqxvUhtYem+QacOH6D4wS/b2Xy9dFQswXXTA3bRNnjUMQof8Idn0
nZ2XKjCAZv/WY4dO7KikTXdf8JbN8eUXSJnpObEVMNQljnWjbT40FesxS7g64jze
2r4AJAessdzBINcq6j3wOdt9rH1Oagy07BcA6K7crufuitRzCbnLnUvUGH60O4vs
k6Z2GoLXZ/Z1L96cE6xIJGajaVzezkTA3WGMLbeSAUyaDS0npoNYQvAl1X3ITRUk
lsLaoB3Y9EReq/lSwxPAaEjAjG65LVX+w4kihTThLSppvXNwMChiNVI=
-----END CERTIFICATE-----
EOF

TEST_RSA_PRIVATE_KEY = <<EOF
-----BEGIN RSA PRIVATE KEY-----
MIIEpAIBAAKCAQEAymY3MxGyBA1VsXIonOaUUMDQjJUIyI7ZmoUhwdwIMju379MN
S1VNV3AEz4o2jze5jUSdPun+O84CnZWb+oREbhqIIyzjk1JJ6/8daGaW9dXBdvNc
Rc8i+Nsl3mQFxboGUwcYflVXY3Deh3DSuwNx8qfVjvipsTceMBHYbIaeDR4X2zpF
fRp9gCfQwS3a1b8RnFIfd/Q3ffj9byxFpDwd5xnVIMJwzSJmcnGYA5AKGW+Ey+q9
80Vt6q4Tj0jB/01db/dlzPbZ9ejAInZIjjhD1zu8d+TMDPO2gTMV2Y8XlTkl4Tr4
BhSfKYQG1e1Vv0lgt+FNkpTmKx352RyKOiz1OwIDAQABAoIBAQCtPtsm8pGe2E8u
iVnsG45+pNyeSP9wtJ3cnvJrPs0hOm7ScKQjhIukOXVUtKjI5FkGa+HxNVdxl4Az
pRkTUV5FpJ49BbJyqvAtenyQnafAG8zy5ZJpCsmTm/oJJzKtsfKx5RP5J1GbA8Tm
yBMJEwTZQQIS1BRkZZqIaO4Izx3AeSenu94vvereRllmuL9OcN162pSS7b/OCJig
qooI2DOIkqg97R2z9KPer+ykR9BjdSWEjq1REtZUj3Ee9L47owytdTa6Qt0spk9y
bSCfuGKRG8HpgPW8NNf32VEIQ6Sd5xCQ8pUAuPAfTNrQeeWQk/EwADdsfggGaMdW
KVvJyM7JAoGBAPhNmMD2AmShxcn3j0QcvJ0TS1CuBbJK514GoibWo90a8J5YHocx
OQH5JxgJ51TfKCTvkDIM0Urqnqy2NXyYu6dXkn629L3YqKylrkxf0rCf96kC9AHY
mmwTJMm1QFnWT+XiwqaQypsRKyhfGy78qQ+5qXQbstYLvXlno4/0bQrnAoGBANCs
WaWpIgr3ocRIc+ybe5lQYRmF9zcM1XREprZQnfOD5+WqGXv6qslKJ8LHm9hIjRLB
vi621SRGtYiibFKllxTFvExB0xJT5XLbbj0Ubic2mSGAi9R2aGCAIXN6DG3eLo3X
1s5iG+ElhIAVmwBDx+DucLICbdGLpusGTd3CR+yNAoGATtgE6zCyrdWYgnszaMNf
ONlJjwLTGDwkn3ynvIFnYuwM/5qnhvIgUfoVadKrPA3oJ2JSfTIIuyso21q4PSoa
XBa4k7fwmt/TH480e1fqBN+mumoPpQ5samjhw5LkLiKZGDwa5t0PGJIpDBa3AQKF
hFLF9fJdpQ3xSj2YeDt67H0CgYEAgNr8nJxdRjJ19PPcia3VW+3Tl+QurRLCuIIw
BAKyFo5MY3hvNiyqy5N8C/4gkSTz4DI9EzGZWkZDkPTjOQHB0nTr+pbnFLkzxYIU
h6kXACXp11M+hVr8xyI4BcvG4w1A6BvxLA5PMu9s637r8PTp906lznZLhArdbuG8
sYRnz30CgYBjNxt1kcxdXrSVOkevLrMb5Sv6qFjr0WGuH21NiVjHZvNNzjpywTeL
SLcE0rLggDP7Pgz9YmPM0SRw0QEwiymiwBI00WjHKjKSEcX3BjTZjrurp6kZca4O
jR5bRq2rVxDZtbPkLduSpvvpU9E1XPr9ZugpaSaVkRJK0sc6QzZfMw==
-----END RSA PRIVATE KEY-----
EOF


Myclear.seller_exchange_id = 'EX00000000'
Myclear.seller_id = 'SE00000000'
# Myclear.service_host = 'https://uat.mepsfpx.com.my'
Myclear.private_key = TEST_RSA_PRIVATE_KEY
Myclear.fpx_certification = TEST_RSA_CERTIFICATE
