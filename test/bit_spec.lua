basexx = require( "basexx" )

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