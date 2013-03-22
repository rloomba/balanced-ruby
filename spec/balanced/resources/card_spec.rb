require "spec_helper"

describe Balanced::Card do

  before do
    api_key = Balanced::ApiKey.new.save
    Balanced.configure api_key.secret

    @marketplace = Balanced::Marketplace.new.save

  end

  describe "filter" do

    before do
      @valid_card = Balanced::Card.new(
          :card_number => "5105105105105100",
          :expiration_month => "12",
          :expiration_year => "2015"
      ).save
      @buyer = @marketplace.create_buyer('a@b.c', @valid_card.uri)
      @invalid_card = Balanced::Card.new(
          :card_number => "5105105105105100",
          :expiration_month => "12",
          :expiration_year => "2015"
      ).save
      @buyer.add_card(@invalid_card.uri)
      @invalid_card.invalidate
    end

    context 'filter valid' do
      it "should filter invalid cards" do

        subject { @buyer.cards.find(:all, :is_valid=>true).length }
        it { should eql 1 }

      end

    end

  end

end
