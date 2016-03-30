# A method #stock_picker that takes in an array of stock prices, 
# one for each hypothetical day. Returns a pair of days representing 
# the best day to buy and the best day to sell. Days start at index 0.

def stock_picker(prices)
	# Empty hash for saving the buy & sell days (key) and the proffit (value)
	buy_sell = Hash.new

	prices.each do |buy|
		# loop inside the loop that caluclates proffit ONLY IF the sell date has higher index than the buy date in the array.
		prices.each do |sell|
			if prices.index(sell) > prices.index(buy)
				proffit = sell - buy
				# Saves the buy index, sell index and proffit into our hash
				buy_sell["#{prices.index(buy)}, #{prices.index(sell)}"] = proffit
			end
		end
	end
	# lists the hash key (buy & sell day) that had the highest proffit value.
	puts buy_sell.key(buy_sell.values.max)
end

stock_picker([30,7,18,3,13,6,2])