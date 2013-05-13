require 'spec_helper'

describe Task do
  before :each do
    @task = FactoryGirl.build :task, :valid
  end

  describe "validate the title field" do
    it "needs to be present" do
      @task.title = nil
      expect(@task.save).to eq false
    end

    it "cannot be empty" do
      @task.title = ""
      expect(@task.save).to eq false
    end

    describe "when containing blank characters" do
      describe "and an invalid title" do
        it "should fail" do
          ["      ", "  abc ", "ab   "].each do |title|
            @task.title = title
            expect(@task.save).to eq false
          end
        end
      end

      describe "and a valid title" do
        it "trims the spaces an save correctly" do
          ["good ", " good ", "good  ", "   good", "\tgood"].each do |title|
            @task.title = title
            expect(@task.save).to eq true
            expect(@task.title).to eq "good"
          end
        end
      end
    end
  end

  describe 'validate the task_list field' do
    it "should be present" do
      @task.task_list = nil
      expect(@task.save).to eq false
    end

    it "should be accessible" do
      list = FactoryGirl.create :task_list
      @task.task_list = list
      expect(@task.save).to eq true
      expect(@task.task_list).to eq list
    end
  end

  describe "validate the user field" do
    it "doesn't need to be present" do
      @task.user = nil
      expect(@task.save).to eq true
    end

    describe "with an existing user assigned" do
      before :each do
        @user = FactoryGirl.create :user
        @task.user = @user
      end

      it "should save correctly" do
        expect(@task.save).to eq true
      end

      it "can change the assigned user anytime" do
        @task.user = FactoryGirl.create :user
        expect(@task.save).to eq true
      end
    end
  end

  describe "validate the finished field" do
    it 'should be false by default' do
      expect(@task.finished).to eq false
    end
  end

  describe '#finish!' do
    it "should set the finished boolean to true" do
      @task.finish!
      expect(@task.finished).to eq true
    end

    it 'should be able to turn the finished boolean to false with a parameter' do
      @task.finish! false
      expect(@task.finished).to eq true
    end
  end
end
