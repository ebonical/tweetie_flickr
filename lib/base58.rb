# Base58
# Credit for this goes to Douglas F Shearer.
# http://github.com/dougal/base58/blob/master/lib/base58.rb
# 
class Base58
 
  ALPHABET = "123456789abcdefghijkmnopqrstuvwxyzABCDEFGHJKLMNPQRSTUVWXYZ"
  BASE = ALPHABET.length
 
  # Converts a base58 string to a base10 integer.
  def self.decode(base58_val)
    int_val = 0
    base58_val.reverse.split(//).each_with_index do |char,index|
      int_val += (ALPHABET.index(char))*(BASE**(index))
    end
    int_val
  end
 
  # Converts a base10 integer to a base58 string.
  def self.encode(int_val)
    base58_val = ''
    while(int_val >= BASE)
      mod = int_val % BASE
      base58_val = ALPHABET[mod,1] + base58_val
      int_val = (int_val - mod)/BASE
    end
    ALPHABET[int_val,1] + base58_val
  end
  
end