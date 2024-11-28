aws acm import-certificate \
  --certificate fileb://ssl/certificate.crt \
  --private-key fileb://ssl/private.key \
  --certificate-chain fileb://ssl/ca_bundle.crt