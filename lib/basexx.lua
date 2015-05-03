------------------------------------------------------------------------------------------------------------------------
-- util functions
------------------------------------------------------------------------------------------------------------------------

local function divide_string( str, max, fillChar )
   fillChar = fillChar or ""
   local result = {}

   local start = 1
   for i = 1, #str do
      if i % max == 0 then
         table.insert( result, str:sub( start, i ) )
         start = i + 1
      elseif i == #str then
         table.insert( result, str:sub( start, i ) )
      end
   end

   return result
end

local function number_to_bit( num, length )
   local bits = {}

   while num > 0 do
      local rest = math.fmod( num, 2 )
      table.insert( bits, rest )
      num = ( num - rest ) / 2
   end

   while #bits < length do
      table.insert( bits, "0" )
   end

   return string.reverse( table.concat( bits ) )
end

------------------------------------------------------------------------------------------------------------------------

local basexx = {}

------------------------------------------------------------------------------------------------------------------------
-- base2(bitfield) decode and encode function
------------------------------------------------------------------------------------------------------------------------

local bitMap = { o = "0", i = "1", l = "1" }

function basexx.from_bit( str )
   str = string.lower( str )
   str = str:gsub( '[ilo]', function( c ) return bitMap[ c ] end )
   return ( str:gsub( '........', function ( cc )
               return string.char( tonumber( cc, 2 ) )
            end ) )
end

function basexx.to_bit( str )
   return ( str:gsub( '.', function ( c )
               local byte = string.byte( c )
               local bits = {}
               for i = 1,8 do
                  table.insert( bits, byte % 2 )
                  byte = math.floor( byte / 2 )
               end
               return table.concat( bits ):reverse()
            end ) )
end

------------------------------------------------------------------------------------------------------------------------
-- base16(hex) decode and encode function
------------------------------------------------------------------------------------------------------------------------

function basexx.from_hex( str )
   return ( str:gsub( '..', function ( cc )
               return string.char( tonumber( cc, 16 ) )
            end ) )
end

function basexx.to_hex( str )
   return ( str:gsub( '.', function ( c )
               return string.format('%02X', string.byte( c ) )
            end ) )
end

------------------------------------------------------------------------------------------------------------------------
-- generic function to decode and encode base32/base64
------------------------------------------------------------------------------------------------------------------------

local function from_basexx( str, alphabet, bits )
   local result = {}
   for i = 1, #str do
      local c = string.sub( str, i, i )
      if c ~= '=' then
         local index = string.find( alphabet, c )
         table.insert( result, number_to_bit( index - 1, bits ) )
      end
   end

   local value = table.concat( result )
   local pad = #value % 8
   return basexx.from_bit( string.sub( value, 1, #value - pad ) )
end

local function to_basexx( str, alphabet, bits, pad )
   local bitString = basexx.to_bit( str )

   local chunks = divide_string( bitString, bits )
   local result = {}
   for key,value in ipairs( chunks ) do
      if ( #value < bits ) then
         value = value .. string.rep( '0', bits - #value )
      end
      local pos = tonumber( value, 2 ) + 1
      table.insert( result, alphabet:sub( pos, pos ) )
   end

   table.insert( result, pad )
   return table.concat( result )   
end

------------------------------------------------------------------------------------------------------------------------
-- rfc 3548: http://www.rfc-editor.org/rfc/rfc3548.txt
------------------------------------------------------------------------------------------------------------------------

local base32Alphabet = "ABCDEFGHIJKLMNOPQRSTUVWXYZ234567"

function basexx.from_base32( str )
   return from_basexx( string.upper( str ), base32Alphabet, 5 )
end

function basexx.to_base32( str )
   return to_basexx( str, base32Alphabet, 5, ({ '', '======', '====', '===', '=' })[ #str % 5 + 1 ] )
end

------------------------------------------------------------------------------------------------------------------------
-- crockford: http://www.crockford.com/wrmg/base32.html
------------------------------------------------------------------------------------------------------------------------

local crockfordAlphabet = "0123456789ABCDEFGHJKMNPQRSTVWXYZ"
local crockfordMap = { O = "0", I = "1", L = "1", U = "V" }

function basexx.from_crockford( str )
   str = string.upper( str )
   str = str:gsub( '[ILOU]', function( c ) return crockfordMap[ c ] end )
   return from_basexx( str, crockfordAlphabet, 5 )
end

function basexx.to_crockford( str )
   return to_basexx( str, crockfordAlphabet, 5, "" )
end

------------------------------------------------------------------------------------------------------------------------
-- base64 decode and encode function
------------------------------------------------------------------------------------------------------------------------

local base64Alphabet='ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/'
 
function basexx.from_base64( str )
   return from_basexx( str, base64Alphabet, 6 )
end

function basexx.to_base64( str )
   return to_basexx( str, base64Alphabet, 6, ({ '', '==', '=' })[ #str % 3 + 1 ] )
end

------------------------------------------------------------------------------------------------------------------------

return basexx
