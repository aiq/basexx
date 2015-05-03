basexx = require( "basexx" )

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