require 'spec_helper'

describe "ArticlesPages" do
  before do
    30.times { FactoryGirl.create(:article) }
  end

  def fill_in_form
      fill_in 'Title', with: 'Soda'
      fill_in 'Body', with: "Everyone always says soda is bad for you, but it's
                             all just bullshit."
  end

  describe "articles index page" do

    subject { page }

    describe "main page" do
      before { visit root_path }

      it { should have_content('Articles') }
      it { should have_content('new article') }
    end

    describe "article brings you to article page" do
      before do
        visit root_path
        a = Article.last
        find("#article-#{a.id}").click
      end

      it "should change page" do
        current_path.should =~ Regexp.new('articles/\d+')
      end
    end
  end

  describe "article#new page" do
    def submit_new_article
      visit new_article_path
      fill_in_form
      click_button 'Create Article'
    end

    subject { page }

    it "creates a new article" do
      expect { submit_new_article }.to change(Article, :count).by(1)
    end
  end

  describe "article#edit action" do
    def edit_article(article)
      visit edit_article_path(article)
      fill_in_form
      click_button 'Update Article'
    end

    subject { page }

    before { edit_article(Article.last) }

    it { should have_content("Soda") }
    it { should have_content("bullshit") }
  end
end
