require "spec_helper"

describe Invitation do
  before :each do
    @invitation = FactoryGirl.create :invitation
  end

  it "has a valid factory" do
    @invitation.should be_valid
  end

  describe 'email' do
    it 'checks that the email is present' do
      @invitation.email = nil
      @invitation.save.should be_false
    end
    it 'checks that the email has a good syntax' do
      @invitation.email = "lolilol"
      @invitation.save.should be_false
    end

    describe 'when two users belonging to different families invite the same member' do
      before :each do
        @user1 = FactoryGirl.create :user, :in_new_family
        @user2 = FactoryGirl.create :user, :in_new_family

        @first_invitation = FactoryGirl.build :invitation, user: @user1, family_id: @user1.family_id
        @second_invitation = FactoryGirl.build :invitation, email: @first_invitation.email, user: @user2, family_id: @user2.family_id
      end

      it "should allow the two different emails to exist" do
        @first_invitation.save.should be_true
        @second_invitation.save.should be_true
      end
    end
    describe 'when two users belonging the same family invite the same member' do
      before :each do
        @family = FactoryGirl.create :family
        @user1 = FactoryGirl.create :user, family: @family
        @user2 = FactoryGirl.create :user, family: @family

        @first_invitation = FactoryGirl.build :invitation, user: @user1, family: @user1.family
        @second_invitation = FactoryGirl.build :invitation, email: @first_invitation.email, user: @user2, family: @user2.family
      end

      it "shouldn't allow the two different emails to exist" do
        @first_invitation.save.should be_true
        @second_invitation.save.should be_false
      end
    end
  end

  describe 'status' do
    it 'the default status should be "pending"' do
      expect(@invitation.status).to eq "pending"
    end
    it 'checks for the inclusion of the status string' do
      @invitation.status = "lolilol"
      @invitation.save.should be_false
    end
    it 'should allow an "accepted" status' do
      @invitation.status = "accepted"
      @invitation.save.should be_true
    end
    it 'should allow a "rejected" status' do
      @invitation.status = "rejected"
      @invitation.save.should be_true
    end
  end

  describe 'family relation' do
    it 'checks for the presence of the family_id' do
      @invitation.family_id = nil
      @invitation.save.should be_false
    end

    describe "when I create a family and assign it to my invitation" do
      before :each do
        @family = FactoryGirl.create :family

        @invitation.family = @family
        @invitation.save!
      end

      it 'should delete the invitation when the family is delete' do
        @family.destroy

        Invitation.find_by_id(@invitation.id).should be_nil
      end
    end
  end

  describe 'user relation' do
    it 'checks for the presence of the user_id' do
      @invitation.user_id = nil
      @invitation.save.should be_false
    end
  end
end
