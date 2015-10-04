# Part of https://github.com/chris-rock/node-crypto-examples
# Nodejs encryption with CTR

crypto    = require('crypto')
algorithm = 'aes-256-ctr'
secret    = 'bc415e5910ddc90784c75a5ad8361e71'

module.exports = 
  simple:
    encrypt: (text) ->
      cipher = crypto.createCipher(algorithm, secret)
      crypted = cipher.update(text, 'utf8', 'hex')
      crypted += cipher.final('hex')
      crypted

    decrypt: (text) ->
      decipher = crypto.createDecipher(algorithm, secret)
      dec = decipher.update(text, 'hex', 'utf8')
      dec += decipher.final('utf8')
      dec