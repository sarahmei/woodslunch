require 'spec_helper'

describe 'Account users' do

  let!(:user) { Factory(:user) }
  let!(:account) { user.account }

  before(:each) do
    sign_in_as(user)
  end

  describe 'GET edit' do
    it 'displays form' do
      visit edit_account_user_path(account, user)
      page.should have_css('form')
    end
  end

  describe 'PUT update' do

    it 'redirects to account path' do
      pending
      visit edit_account_user_path(user)
      select '2', :from => 'user_preferred_grade'
      click_button 'Submit'
      page.current_path.should == account_path(account)
    end

    it 'sets preferred_grade' do
      pending
      visit edit_account_user_path(user)
      select '2', :from => 'user_preferred_grade'
      expect {
        click_button 'Submit'
      }.to change { user.reload.preferred_grade }.from(nil).to('2')
    end

    it 'displays flash notice' do
      pending
      visit edit_account_user_path(user)
      select '2', :from => 'user_preferred_grade'
      click_button 'Submit'
      page.should have_css('div.flash#notice')
    end
  end

end