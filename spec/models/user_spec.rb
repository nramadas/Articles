require 'spec_helper'

describe User do
  describe "model attributes" do
    before do
      @user = FactoryGirl.build(:user)
    end

    subject { @user }

    it { should respond_to(:name ) }
    it { should respond_to(:email) }
    it { should respond_to(:password) }
    it { should respond_to(:password_confirmation) }

    describe "name can't be blank" do
      before { @user.name = nil }
      it { should_not be_valid }
    end

    describe "email can't be blank" do
      before { @user.email = nil }
      it { should_not be_valid }
    end

    describe "password can't be blank" do
      before { @user.password = @user.password_confirmation = nil }
      it { should_not be_valid }
    end

    describe "password_confirmation can't be blank" do
      before { @user.password_confirmation = nil }
      it { should_not be_valid }
    end

    describe "email must be unique" do
      before { @user.save; @user2 = User.new(name: 'fake',
                                             email: @user.email,
                                             password: '12345678',
                                             password_confirmation: '12345678')}
      subject { @user2 }
      it { should_not be_valid }
    end

    describe "password should be at least 8 characters" do
      before { @user.password = @user.password_confirmation = '1234567' }
      it { should_not be_valid }
    end

    describe "password should match password confirmation" do
      before { @user.password = '12345678' }
      it { should_not be_valid }
    end

    describe "email must be in valid format" do
      before { @user.email = "billy" }
      it { should_not be_valid }
    end
  end

  describe "model associations" do
    before do
      @user = FactoryGirl.create(:user)
    end

    subject { @user }

    describe "user should author an article" do
      before { FactoryGirl.create(:article) }

      it "should have an article" do
        @user.authored_articles.should_not be_empty
      end
    end

    describe "user can have many authored_articles" do
      before { 50.times { FactoryGirl.create(:article) } }

      it "should have all the articles" do
        @user.authored_articles.length.should eq(50)
      end
    end

    describe "user should be able to collab" do
      before do
        @user.contributed_articles << FactoryGirl.create(:article)
      end

      it "should have a collaborated article" do
        @user.contributed_articles.should_not be_empty
      end
    end
  end
end