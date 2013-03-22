cwd = File.dirname(File.dirname(File.absolute_path(__FILE__)))
$:.unshift(cwd + "/lib")
require 'balanced'

api_key = Balanced::ApiKey.new.save
secret = api_key.secret

Balanced.configure(secret)
marketplace = Balanced::Marketplace.new.save
card = Balanced::Card.new(
  :card_number => "5105105105105100",
  :expiration_month => "12",
  :expiration_year => "2015",
).save

buyer = marketplace.create_buyer(
    :email_address => "buyer@example.org",
    :card_uri => card.uri
)

card = Balanced::Card.new(
  :card_number => "5105105105105100",
  :expiration_month => "12",
  :expiration_year => "2015",
).save

buyer.add_card(card.uri)

card.invalidate

buyer.cards.find(:all, :is_valid => true)