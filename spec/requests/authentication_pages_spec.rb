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
      before { log_in(usuario) }
            
      it { should have_selector('title', text: usuario.nombre) }
      it { should have_link('Salir', href: logout_path) }
      it { should_not have_link('Entrar', href: login_path) }
      
      describe "followed by logout" do
        before { click_link "Salir" }
        it { should have_link('Entrar', href: login_path) }
      end
    end
  end

  describe "authorization" do
    
    describe "for no loged in users" do
      let(:usuario) { FactoryGirl.create(:usuario) }

      describe "in the usuarios controller" do

        describe "visiting the edit page" do
          before { visit edit_usuario_path(usuario) }
          it { should have_selector('title', text: 'Log in') }
        end
        
        describe "submiting the update action" do
          before { put usuario_path(usuario) }
          specify { response.should redirect_to(login_path)}
        end
      end
      
    end

    describe " for log in user" do

      describe "admin" do
        let(:admin) { FactoryGirl.create(:admin) }
        before { log_in admin }
        
        it { should have_selector('title', text: "Usuarios") }
      end

      describe "tecnico" do
        let(:tecnico) { FactoryGirl.create(:tecnico) }
        before { log_in tecnico }

        it { should have_selector('title', text: "Usuarios") }
        it { should have_link('Registrar cliente', href: registro_path) }

        describe "registro cliente" do
          before { visit registro_path }
          
          it { should have_selector('title', text: "Registro") }
        end
      end

      describe "vendedor" do
        let(:vendedor) { FactoryGirl.create(:vendedor) }
        before { log_in vendedor }

        it { should have_selector('title', text: "Usuarios") }
      end

      describe "cliente" do
        let(:cliente) { FactoryGirl.create(:usuario) }
        before { log_in cliente }

        it { should have_selector('title', text: cliente.nombre) }
      end
    end

    describe "editar un perfil como cliente" do
      
      describe "de otro cliente" do
        let(:cliente) { FactoryGirl.create(:usuario) }
        let(:other_cliente) { FactoryGirl.create(:usuario, nombre: "otro" ,email: "otro@usuario.com") }
        before { log_in cliente }
        
        describe "visit other_cliente page" do
          before { visit usuario_path(other_cliente) }
          it { should_not have_selector('title', text: other_cliente.nombre) }
        end

        describe "visit other cliente update page" do
          before { visit edit_usuario_path(other_cliente) }
          it { should_not have_selector('title', text: "Editar") }
        end

        describe "editar otro cliente con PUT sobre update action" do
          before { put usuario_path(other_cliente) }
          specify { response.should redirect_to(root_path) }
        end
      end
    end
  end
end
