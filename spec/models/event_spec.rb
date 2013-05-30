require 'spec_helper'

describe Event do
  before :each do
    @event = FactoryGirl.build :event, start_date: 2.hours.ago, end_date: 1.hour.ago 
  end

  describe "title" do
    it "needs to be present" do
      @event.title = nil
      expect(@event.save).to eq false
    end

    it "cannot be empty" do
      @event.title = ""
      expect(@event.save).to eq false
    end

    describe "when containing blank characters" do
      describe "and an empty title" do
        it "should fail" do
          ["      ", "\t", "  \t     \t"].each do |title|
            @event.title = title
            expect(@event.save).to eq false
          end
        end
      end

      describe "and a valid title" do
        it "trims the spaces an save correctly" do
          ["good ", " good ", "good  ", "   good", "\tgood"].each do |title|
            @event.title = title
            expect(@event.save).to eq true
            expect(@event.title).to eq "good"
          end
        end
      end
    end
  end

  describe "description" do
    it "is not needed" do
      @event.description = nil
      expect(@event.save).to be true
    end

    it "can contain a lot of characters" do
      @event.description = Forgery(:lorem_ipsum).words(250)
      expect(@event.save).to be true
    end

    it "trims its content" do
      @event.description = " good "
      expect(@event.save).to be true
      expect(@event.description).to eq "good"
    end
  end

  describe 'user_id' do
    it "is not needed" do
      @event.user_id = nil
      expect(@event.save).to be true
    end

    describe "with an existing user assigned" do
      before :each do
        @user = FactoryGirl.create :user
        @event.user = @user
      end

      it "saves correctly" do
        expect(@event.save).to eq true
        expect(@event.user).to eq @user
      end
    end
  end

  describe "family_id" do
    it "should be present" do
      @event.family = nil
      expect(@event.save).to be false
    end

    describe "with an existing family assigned" do
      before :each do
        @family = FactoryGirl.create :family
        @event.family = @family
      end

      it "should save correctly" do
        expect(@event.save).to eq true
      end
    end
  end

  describe "start_date" do
    it "should be present" do
      @event.start_date = nil
      expect(@event.save).to be false
    end

    describe "when starting now" do
      before :each do
        @event.start_date = Time.now
      end

      it "shouldn't be valid with an anterior end_date" do
        @event.end_date = 3.weeks.ago
        expect(@event.save).to be false
      end

      it "should be valid with a posterior end_date" do
        @event.end_date = Time.now + 3.weeks
        expect(@event.save).to be true
      end      
    end
  end

  describe "end_date" do
    it "should be present" do
      @event.end_date = nil
      expect(@event.save).to be false
    end
  end

  describe "with an existing past event, another currently going and another to come" do
    before :each do
      @old = FactoryGirl.create :event, start_date: 3.weeks.ago, end_date: 2.weeks.ago, title: "The past"
      @current = FactoryGirl.create :event, start_date: 1.hour.ago, end_date: (Time.now + 3.hours), title: "The present"
      @incoming = FactoryGirl.create :event, start_date: (Time.now + 5.hours), end_date: (Time.now + 6.hours), title: "The Future"
    end

    describe "#currents_and_futures" do
      it "should list the current and the incoming one" do
        expect(Event.currents_and_futures).to eq [@current, @incoming]
      end
    end
  end
end
