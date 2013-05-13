require 'spec_helper'

describe TaskList do
  before :each do
    @list = FactoryGirl.build :task_list
  end

  describe "the title field" do
    it "needs to be present" do
      @list.title = nil
      expect(@list.save).to eq false
    end

    it "cannot be empty" do
      @list.title = ""
      expect(@list.save).to eq false
    end

    describe "when containing blank characters" do
      describe "and an invalid title" do
        it "should fail" do
          ["      ", "  abc ", "ab   "].each do |title|
            @list.title = title
            expect(@list.save).to eq false
          end
        end
      end

      describe "and a valid title" do
        it "trims the spaces an save correctly" do
          ["good ", " good ", "good  ", "   good", "\tgood"].each do |title|
            @list.title = title
            expect(@list.save).to eq true
            expect(@list.title).to eq "good"
          end
        end
      end
    end
  end

  describe "the description field" do
    it "is not needed" do
      @list.description = nil
      expect(@list.save).to be true
    end

    it "can contain a lot of characters" do
      @list.description = Forgery(:lorem_ipsum).words(250)
      expect(@list.save).to be true
    end

    it "trims its content" do
      @list.description = " good "
      expect(@list.save).to be true
      expect(@list.description).to eq "good"
    end
  end

  describe 'the author field' do
    it "is not needed" do
      @list.author_id = nil
      expect(@list.save).to be true
    end

    describe "with an existing user assigned" do
      before :each do
        @user = FactoryGirl.create :user
        @list.author = @user
      end
    end
  end

  describe "the family field" do
    it "should be present" do
      @list.family = nil
      expect(@list.save).to be false
    end

    describe "with an existing family assigned" do
      before :each do
        @family = FactoryGirl.create :family
        @list.family = @family
      end

      it "should save correctly" do
        expect(@list.save).to eq true
      end
    end
  end

  describe "tasks" do
    before :each do
      @list.save
    end

    it "shouldn't contain any task at first" do
      expect(@list.tasks).to be_empty
    end

    describe "when creating 3 tasks 'jambon', 'morue' and 'semoule'" do
      before :each do
        @jambon = FactoryGirl.create :task, task_list_id: @list.id, title: 'jambon'
        @morue = FactoryGirl.create :task, task_list_id: @list.id, title: 'morue'
        @semoule = FactoryGirl.create :task, task_list_id: @list.id, title: 'semoule'
      end

      it 'should contain three tasks' do
        expect(@list.tasks.length).to be 3
      end

      describe 'when the tasks are not completed yet' do
        describe '#status' do

          it "should return a status 'open'" do
           expect(@list.status).to eq "open"
         end
        end
      end

      describe 'when the tasks are finished' do
        before :each do
          @jambon.finish!
          @morue.finish!
          @semoule.finish!
        end

        describe '#status' do
          it "should return a status 'finished'" do
            expect(@list.status).to eq "finished"
          end
        end
      end      
    end
  end
end
