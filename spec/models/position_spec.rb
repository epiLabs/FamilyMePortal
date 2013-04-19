require 'spec_helper'

describe Position do
  before :each do
    @position = FactoryGirl.build :position, :valid_coordinates
  end

  it 'needs a user to be valid' do
    @position.save.should be_false
  end

  describe "with a user assigned" do
    before :each do
      @user = FactoryGirl.create :user
      @position.user = @user
    end

    it 'should be valid' do
      @position.save.should be_true
    end

    describe 'when using bad coordinates' do
      before :each do
        @coordinates = [
          [nil, nil],
          [-99.34442, 0.0034324],
          [54.424232, 192.34355],
          [90.000001, 1.2349829]
        ]
      end

      it 'should not save my model' do
        @coordinates.each do |latitude, longitude|
          @position.latitude = latitude
          @position.longitude = longitude
          @position.save.should be_false
        end
      end
    end

    describe 'when using valid coordinates' do
      before :each do
        @coordinates = [
          [23.234433, 98.34677],
          [89.999999, 179.99999],
          [-89.99999, -179.9999],
          [0, 0]
        ]
      end

      it 'should save my model' do
        @coordinates.each do |latitude, longitude|
          @position.latitude = latitude
          @position.longitude = longitude
          @position.save.should be_true
        end
      end
    end
  end
end
