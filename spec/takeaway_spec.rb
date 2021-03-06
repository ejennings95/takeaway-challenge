require 'takeaway'

describe Takeaway do
  let(:item) { double(:item) }
  let(:new_order) { double(:new_order) }

  describe '#menu' do
    it { is_expected.to respond_to(:view_menu) }

    it 'should access the menu from a Menu class' do
      expect(subject.menu).to receive(:view_food_and_price)
      subject.view_menu
    end
  end

  describe '#order' do
    it { is_expected.to respond_to(:place_order).with(2) }

    it 'can call the add to order method allowing an item to be added to the order' do
      expect_any_instance_of(Order).to receive(:add_to_order)
      subject.place_order(item, 1)
    end

    it 'should start a new order' do
      expect { subject.new_order }.to change { subject.order }
    end
  end

  describe '#price' do
    it 'can call the total price method allowing the price to be returned' do
      expect_any_instance_of(Order).to receive(:total_price)
      subject.price
    end
  end

  describe '#confirmation' do
    it 'can call the confirmation of order method on an instance of confirmation' do
      expect_any_instance_of(Confirmation).to receive(:confirmation_of_order)
      subject.confirmation
    end
  end
end
