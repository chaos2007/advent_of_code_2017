
def reverse_segment( chain, length, index )
    #case 1.  Where it does not wraparound.
    if index + length < chain.length
        prefix = chain[0,index]
        reverse_portion = chain[index, length].reverse
        postfix = chain[index+length, chain.length-(index+length)]
        prefix + reverse_portion + postfix
    #case 2. Where it does wraparound.
    else
        wraparound_amount = (index + length) - chain.length
        ending_amount = length - wraparound_amount
        first = chain[index, ending_amount]
        second = chain[0, wraparound_amount]
        reverse_portion = (first + second).reverse
        reverse_portion[ending_amount, reverse_portion.length] + chain[wraparound_amount, index-wraparound_amount] + reverse_portion[0, ending_amount]
    end
end
   
def calculate_chain( chain, lengths )
    index = 0
    lengths.each_with_index do |length, step_size|
        chain = reverse_segment( chain, length, index )
        index = (index + step_size + length) % chain.length
    end
    chain[0] * chain[1]
end

def convert_ascii_to_byte_array( ascii )
    byte_array = ascii.chars.map do |element|
        element.ord
    end
end

def calculate_hash( ascii_string ) 
    chain = (0..255).to_a
    suffix = [17, 31, 73, 47, 23]
    lengths = convert_ascii_to_byte_array(ascii_string) + suffix
    index = 0
    skip_size = 0
    (0..63).each do |counter|
        lengths.each do |length|
            chain = reverse_segment( chain, length, index )
            index = (index + skip_size + length) % chain.length
            skip_size += 1
        end
    end
    checksum_bytes = (0..15).to_a.map do |bucket|
        "%02x" % create_sparse_hash( chain[bucket*16, 16])
    end
    checksum_bytes.reduce("") { |sum, element| sum + element }
end

def create_sparse_hash( byte_array )
    byte_array.reduce(0) { |sum, element| sum ^ element }
end