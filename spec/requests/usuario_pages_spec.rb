require 'spec_helper'

describe "Usuario Pages" do
   subject { page }

   describe "index page" do
    before { visit root_path }
              
    it { should have_selector('title', text: "Usuarios") }
   end
   
end
  