require 'spec_helper'

describe "Pages" do
  subject {page}
  
  describe "Home page" do
    before { visit root_path}
    
    it {should have_selector('h1', :text => 'Good Task Manager')}
    it {should have_selector('title', :text => "the-feel Good Task Manager")}
    
  end
end
