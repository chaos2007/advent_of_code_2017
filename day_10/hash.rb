
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