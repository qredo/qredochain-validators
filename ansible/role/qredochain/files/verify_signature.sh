#!/usr/bin/env bash

openssl dgst -sha256 -verify "pub.pem" -signature "qredochain.1.10.6-cb4a29101.tar.gz.sig" "qredochain.1.10.6-cb4a29101.tar.gz"
