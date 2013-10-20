basexx = require( "basexx" )

describe( "base library", function()
   describe( "should handle bitfields strings", function()
      it( "should convert data to a bitfields string", function()
         assert.is.same( "01000001010000110100010001000011", basexx.to_bit( "ACDC" ) )
      end)
      it( "should read data from a bitfields string", function()
         assert.is.same( "ACDC", basexx.from_bit( "01000001010000110100010001000011" ) )
      end)
      it( "should read data from a bitfields string that uses o instead of 0", function()
         assert.is.same( "AC", basexx.from_bit( "o1ooooo1o1oooo11" ) )
         assert.is.same( "AC", basexx.from_bit( "OioooooiOiooooii" ) )
      end)
   end)

   describe( "should handle hex strings", function()
      it( "should convert data to a hex string", function()
         assert.is.same( "48656C6C6F20776F726C6421", basexx.to_hex( "Hello world!" ) )
      end)
      it( "should read data from a upper and lower hex string", function()
         assert.is.same( "Hello world!", basexx.from_hex( "48656C6C6F20776F726C6421" ) )
         assert.is.same( "Hello world!", basexx.from_hex( "48656c6c6f20776f726c6421" ) )
      end)
   end)

   describe( "should handle base32(rfc3548) strings", function()
      it( "should convert data to a base32 string", function()
         -- https://github.com/stesla/base32
         assert.is.same( "MNUHK3TLPEQGEYLDN5XCC===", basexx.to_base32( "chunky bacon!" ) )
      end)
      it( "should read data from a base32 string", function()
         -- https://github.com/stesla/base32
         assert.is.same( "chunky bacon!", basexx.from_base32( "MNUHK3TLPEQGEYLDN5XCC===" ) )
      end)
   end)

   describe( "should handle base32(crockford) strings", function()
      it( "should convert data to a base32 string", function()
         -- https://github.com/ingydotnet/crockford-py/blob/master/tests/test_functions.py
         assert.is.same( "CSQPY", basexx.to_crockford( "foo" ) )
      end)
      it( "should read data from a base32 string", function()
         -- https://github.com/ingydotnet/crockford-py/blob/master/tests/test_functions.py
         assert.is.same( "foo", basexx.from_crockford( "CSQPY" ) )
      end)
   end)

   describe( "should handle base64 strings", function()
      local longtxt = [=[Man is distinguished, not only by his reason, but by this singular passion from other
 animals, which is a lust of the mind, that by a perseverance of delight in the continued and indefatigable generation
 of knowledge, exceeds the short vehemence of any carnal pleasure.]=]     
      local long64 = [=[TWFuIGlzIGRpc3Rpbmd1aXNoZWQsIG5vdCBvbmx5IGJ5IGhpcyByZWFzb24sIGJ1dCBieSB0aGlzIHNpbmd1bGFyIHBhc3
Npb24gZnJvbSBvdGhlciBhbmltYWxzLCB3aGljaCBpcyBhIGx1c3Qgb2YgdGhlIG1pbmQsIHRoYXQgYnkgYSBwZXJzZXZlcmFuY2Ugb2YgZGVsaWdodCBpbi
B0aGUgY29udGludWVkIGFuZCBpbmRlZmF0aWdhYmxlIGdlbmVyYXRpb24gb2Yga25vd2xlZGdlLCBleGNlZWRzIHRoZSBzaG9ydCB2ZWhlbWVuY2Ugb2YgYW
55IGNhcm5hbCBwbGVhc3VyZS4=]=]

      it( "should convert data to a base64 string", function()
         -- http://en.wikipedia.org/wiki/Base64
         assert.is.same( 'TWFu', basexx.to_base64( 'Man') )
         assert.is.same( 'bGVhc3VyZS4=', basexx.to_base64( 'leasure.') )
         assert.is.same( 'cGxlYXN1cmUu', basexx.to_base64( 'pleasure.') )
         assert.is.same( 'ZWFzdXJlLg==', basexx.to_base64( 'easure.') )
         assert.is.same( 'c3VyZS4=', basexx.to_base64( 'sure.') )

         assert.is.same( string.gsub( long64, "\n", "" ), basexx.to_base64( string.gsub( longtxt, "\n", "" ) ) )
      end)
      it( "should read data from a base64 string", function()
         -- http://en.wikipedia.org/wiki/Base64
         assert.is.same( 'Man', basexx.from_base64( 'TWFu') )
         assert.is.same( 'leasure.', basexx.from_base64( 'bGVhc3VyZS4=') )
         assert.is.same( 'pleasure.', basexx.from_base64( 'cGxlYXN1cmUu') )
         assert.is.same( 'easure.', basexx.from_base64( 'ZWFzdXJlLg==') )
         assert.is.same( 'sure.', basexx.from_base64( 'c3VyZS4=') )


         assert.is.same( string.gsub( longtxt, "\n", "" ), basexx.from_base64( string.gsub( long64, "\n", "" ) ) )
      end)
   end)
end)