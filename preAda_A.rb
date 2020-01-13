# initialize variables for user money, the candy machine selection
$userCash = nil
$machine = Hash.new
# set the selection: the candies and their costs
$machine[:candy1] = ["Snickers", 1.65]
$machine[:candy2] = ["Hawaiian Chips", 2.5]
$machine[:candy3] = ["Pay Day", 1.75]
$machine[:candy4] = ["Spearmint  Gum", 0.75]
$machine[:candy5] = ["Starburst", 1.25]

# helper method inputUserCash(cash) for testing and formatting userCash
# input user's amount of money
# return tested, re-formatted user cash value (float)

def inputUserCash(cash)
    # finding numbers in input, using regexp for digits
    i = cash =~ /\d+(\.\d+)?/

    # removing "$" from beginning of cost, if present
    if (i == 1 || i == 2) && 
            (cash.slice("$") == "$" || cash.slice("$ ") == "$ ")
        cash = cash[i, cash.length]
    end

    # handling if either symbols (other than decimal point) or 
    # alphabetic chars are in input, and if there are no numbers 
    # present in input at all
    if i == nil || (cash =~ /[a-z]/) != nil ||  
            (cash.slice(".") == nil && (cash =~ /\W/) != nil)
        cash = nil
    end

    # if input is incorrect, prompt user until right input is recieved
    if cash == nil 
        puts "Oops! Try taking out commas, extra spaces,
         or checking for typos. Please enter a valid cash amount:"
        cash = inputUserCash(gets.chomp) # recursive method call
    end
    cash.to_f
end


# Helper method dispense() for selecting candy
# calls choose(), tests user selection (if incorrect, error message), tests
# if userCash is enough for selection, reports back to user accordingly, and
# adjusts user cash if selection successful
# recursively calls itself to get new user selection if wrong input entered
# or user doesn't have enough cash

def dispense()
    # prompt for and grab user selection
    puts "\nSelect 1, 2, 3, 4, or 5 (to cancel, enter Q):"
    userSelect = gets.chomp.capitalize
    # use regexp to begin to test user input
    i = userSelect =~ /[12345Q]/
    # test inputted selection, then test correct selection against user cash
    if i == nil || userSelect.length > 1
        puts "Please enter a valid, single selection."
        dispense()
    elsif userSelect == 'Q'
        puts "Aw, okay. See you next time."
    elsif $machine["candy#{userSelect}".to_sym][1] <= $userCash
        $userCash -= $machine["candy#{userSelect}".to_sym][1] # update user cash
        puts "Enjoy your #{$machine["candy#{userSelect}".to_sym][0]}!"
    else
        puts "Oops, you don't have enough for that."
        dispense()
    end
end

# begin main program
puts "\nWelcome to Ada's Virtual Candy Machine! \n"
puts "How much money do you have?:"
$userCash = inputUserCash(gets.chomp)
puts "You've got $#{format("%.2f", $userCash)}"

# Print selection to user
puts "Here's the selection:"
(1..5).each do |n|
    puts "#{n}: #{$machine["candy#{n}".to_sym][0]} $#{format("%.2f", $machine["candy#{n}".to_sym][1])}"
end

# if the user doesn't have enough for anything
if $userCash < 0.75
    puts "Sorry, looks like you don't have enough to buy anything today.
    See you next time!"
# if user has enough for at least one selection:
else
    # grab user Selection, dispense, give change
    dispense()
    puts "Here's your $#{format("%.2f", $userCash)} in change."    
end

