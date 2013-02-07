require 'spec_helper'

describe "Sessions:" do
  def fill_form(user)
    fill_in 'Email', with: "eg#{user.id}@gmail.com"
    fill_in 'Password', with: "mynameiseg"
    click_button 'Sign'
  end

  subject { page }

  describe "sign-in:" do
    before { visit signin_path }

    it "signs in with valid credentials" do
      fill_form(FactoryGirl.create(:user))

      current_path.should =~ Regexp.new('users/\d+')
    end
  end

  describe "authentications:" do
    before { visit signin_path }

    it "rejects invalid credentials" do
      fill_in 'Email', with: 'asdf'

      click_button 'Sign'

      current_path.should =~ Regexp.new('sessions')
    end
  end

  describe "authorization:" do
    before do
      2.times { FactoryGirl.create(:user) }
      visit signin_path
      fill_form(User.first)
    end

    describe "does not authorize access of other users" do
      before { visit user_path(User.last) }

      it { should have_content(User.first.name) }
    end
  end
end
