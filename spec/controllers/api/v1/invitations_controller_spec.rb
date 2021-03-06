require 'spec_helper'

describe Api::V1::InvitationsController do

  before :each do
    @user = FactoryGirl.create :user

    sign_in :user, @user
  end

  describe "I'm on a family" do
    before :each do
      Family.generate_new_including_user(@user)
    end

    describe "GET #index" do
      before :each do
        get :index
      end

      it "responds successfully with an HTTP 200 status code" do
        expect(response).to be_success
        expect(response.status).to eq(200)
      end

      it "renders the index template" do
        expect(response).to render_template("index")
      end

      it "loads all of the invitations sent into @invitations" do
        invitation_1 = FactoryGirl.create :invitation, user: @user, family: @user.family
        invitation_2 = FactoryGirl.create :invitation, user: @user, family: @user.family
        invitation_3 = FactoryGirl.create :invitation, user: @user, family: @user.family

        expect(assigns(:invitations)).to match_array([invitation_1, invitation_2, invitation_3])
      end
    end

    describe "POST #create" do
      describe 'when the email has not been invited yet' do
        before :each do
          post :create, email: 'lolilol@lol.fr'
        end

        it "responds successfully with an HTTP 200 status code" do
          expect(response).to be_success
          expect(response.status).to eq(200)
        end

        it "creates the invitation for the user's family" do
          invitation = Invitation.where(email: 'lolilol@lol.fr').first
          expect(invitation.family).to eq @user.family
          expect(invitation.user).to eq @user
        end
      end

      describe 'when the email has already been invited by this family' do
        before :each do
          @invitation = FactoryGirl.create :invitation, family: @user.family, user: @user

          post :create, invitation: {email: @invitation.email}
        end

        it "responds successfully with an HTTP 400 status code" do
          expect(response.status).to eq(400)
        end
      end
    end
  end

  describe "GET #received" do
    describe "when I was invited into a family" do
      before :each do
        @invitation = FactoryGirl.create :invitation, email: @user.email, user_id: 1, family_id: 26
      end

      it "shows me the invitation" do
        get :received

        expect(assigns(:invitations)).to match_array([@invitation])
      end

      describe "when someone else invites me in his family" do
        it "lists the two invitations" do
          @second_invitation = FactoryGirl.create :invitation, email: @user.email, user_id: 3, family_id: 27

          get :received

          expect(assigns(:invitations)).to match_array([@invitation, @second_invitation])
        end
      end
    end

    it "renders the 'received' template" do
      get :received
      expect(response).to render_template("received")
    end
  end


  describe 'when I receive two invitations' do
    before :each do
      @first_invitation = FactoryGirl.create :invitation, email: @user.email, user_id: 1, family_id: 26
      @second_invitation = FactoryGirl.create :invitation, email: @user.email, user_id: 3, family_id: 27
    end

    describe 'GET accept' do
      describe 'when I accept the first invitation' do
        before :each do
          get :accept, id: @first_invitation.id
        end

        it "responds successfully with an HTTP 200 status code" do
          expect(response).to be_success
          expect(response.status).to eq(200)
        end

        it 'should add me to the family' do
          User.find(@user.id).family_id.should eq @first_invitation.family_id
        end

        it 'should change the second invitation status to rejected' do
          @second_invitation.reload
          
          @second_invitation.status.should == 'rejected'
        end
      end
    end

    describe 'GET reject' do
      describe 'when I reject the first invitation' do
        before :each do
          get :reject, id: @first_invitation.id
        end

        it "responds successfully with an HTTP 200 status code" do
          expect(response).to be_success
          expect(response.status).to eq(200)
        end

        it 'should change the status of the invitation to rejected' do
          @first_invitation.reload

          @first_invitation.status.should == 'rejected'
        end
      end
    end
  end
end
