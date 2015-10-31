basexx = require( "basexx" )

describe( "should handle base32(crockford) strings", function()

   it( "should fulfill crockford-py test case", function()
      -- https://github.com/ingydotnet/crockford-py/blob/master/tests/test_functions.py
      assert.is.same( "CSQPY", basexx.to_crockford( "foo" ) )
      assert.is.same( "foo", basexx.from_crockford( "CSQPY" ) )
   end)

end)
