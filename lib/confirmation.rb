require_relative 'order'
require_relative 'details'
require 'twilio-ruby'

class Confirmation

  include Details
  TIMEPLUS1 = Time.now + (60 * 60)

  def confirmation_of_order(saved_order)
    if saved_order.price.zero?
      saved_order.total_price
    end
    check_confirmation(saved_order)
  end

  def confirmation_text
    account_sid = @sid
    auth_token = @token

    client = Twilio::REST::Client.new account_sid, auth_token

    from = '+441772367485'
    to = @number

    client.messages.create(
    from: from,
    to: to,
    body: "This is a message to confirm the order of your food delivery to arrive at #{TIMEPLUS1}"
    )
  end

  private

  def check_confirmation(saved_order)
    puts "Do you confirm your order of #{saved_order.basket} for the value of #{saved_order.price}?"
    puts "Press enter to confirm"
    answer = gets.chomp.to_s
    if answer == ""
      puts "Thank you, please wait for confirmation text."
      confirmation_text
    else
      "Order not confirmed"
    end
  end

end
