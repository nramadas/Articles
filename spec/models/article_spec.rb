require 'spec_helper'

describe Article do
  describe "Article attributes" do
    before do
      FactoryGirl.create(:user)
      @article = FactoryGirl.build(:article)
    end

    subject { @article }

    it { should respond_to :title }
    it { should respond_to :body  }
    it { should respond_to :author_id }

    describe "title cannot be blank" do
      before { @article.title = nil }
      it { should_not be_valid }
    end

    describe "body cannot be blank" do
      before { @article.body = nil }
      it { should_not be_valid }
    end

    describe "title should be less than 30 characters" do
      before { @article.title = "a"*31 }
      it { should_not be_valid }
    end
  end

  describe "Article associations" do
    before do
      @article = FactoryGirl.create(:article)
    end

    subject { @article }

    describe "can take collaborators" do
      before { @article.collaborators << FactoryGirl.create(:user)}

      it "should have a collaborator" do
        @article.collaborators.should_not be_empty
      end
    end

    describe "can take many collaborators" do
      before { 10.times { @article.collaborators << FactoryGirl.create(:user) }}

      it "should have 10 collaborators" do
        @article.collaborators.length.should eq(10)
      end
    end
  end
end