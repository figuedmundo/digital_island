require 'spec_helper'

describe "AuthenticationPages" do

  subject { page }

  describe "login page" do
    before { visit login_path }

    it { should have_selector('title', text: "Log in") }
    # it { should have_selector('h1', text: "Ingresar") }
  end

  describe "login" do
    before { visit login_path }
    
    describe "with invalid info" do
      before { click_button "Entrar" }
      
      it { should have_selector('title', text: 'Log in') }
      it { should have_selector('div.alert.alert-error') }
    end

    describe "with valid info" do
      let(:usuario) { FactoryGirl.create(:usuario) }
      before do
        fill_in "Email",   with: usuario.email
        fill_in "Password",   with: usuario.password
        click_button 'Entrar'
      end

      it { should have_selector('title', text: usuario.nombre) }
      it { should have_link('Salir', href: logout_path) }
      it { should_not have_link('Entrar', href: login_path) }
      
      describe "followed by logout" do
        before { click_link "Salir" }
        it { should have_link('Entrar', href: login_path) }
      end
    end
  end
  
end
