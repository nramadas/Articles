require 'spec_helper'

describe "UserPages" do
  describe "user#show page" do
    def fill_form(user)
      fill_in 'Email', with: "eg#{user.id}@gmail.com"
      fill_in 'Password', with: "mynameiseg"
      click_button 'Sign'
    end

    before do
      @user = FactoryGirl.create(:user)
      visit signin_path
      fill_form(@user)
    end

    subject { page }

    it { should have_content(@user.name) }
    it { should have_content("Create") }
    it { should have_content("Articles") }


    describe "has authored articles" do
      before do
        @article = FactoryGirl.create(:article)
        @user.authored_articles << @article
        visit user_path(@user)
      end

      it { should have_content(@article.title) }
      # it { should have_button("edit") }
      # it { should have_button("delete") }
    end

    describe "has collaborated articles" do
      before do
        @article = FactoryGirl.create(:article)
        @article.author_id = 2
        @article.save
        @user.contributed_articles << @article
        visit user_path(@user)
      end

      it { should have_content(@article.title) }
      # it { should have_button("edit") }
      # it { should_not have_button("delete") }
    end
  end
end
