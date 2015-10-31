basexx = require( "basexx" )

describe( "should handle hex strings", function()

   it( "should convert data to a hex string", function()
      assert.is.same( "48656C6C6F20776F726C6421",
                      basexx.to_hex( "Hello world!" ) )
   end)

   it( "should read data from a upper and lower hex string", function()
      assert.is.same( "Hello world!",
                      basexx.from_hex( "48656C6C6F20776F726C6421" ) )
      assert.is.same( "Hello world!",
                      basexx.from_hex( "48656c6c6f20776f726c6421" ) )
   end)

end)
