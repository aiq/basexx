basexx = require( "basexx" )

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