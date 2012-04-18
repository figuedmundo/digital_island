require 'spec_helper'

describe "Usuario Pages" do
  subject { page }

  describe "index page" do
    before { visit root_path }
              
    it { should have_selector('title', text: "Log in") }

    describe "log in users" do
      describe "admin or tecnico or vendedor" do
        let(:admin) { FactoryGirl.create(:admin) }
        before do
          log_in admin
          visit root_path 
        end

        it { should have_selector('title', text: "Usuarios") }
      end

      describe "cliente" do
        let(:cliente) { FactoryGirl.create(:usuario) }
        before do
          log_in cliente
          visit root_path 
        end

        it { should_not have_selector('title', text: "Usuarios") }
      end

    end
    
  end

  describe "show(usuario) page" do
    let(:usuario) { FactoryGirl.create(:usuario) }
    before do
      log_in usuario
      visit usuario_path(usuario) 
    end
    
    it { should have_selector('title', text: usuario.nombre) }
    it { should have_selector('h1', text: usuario.nombre) }
  end
   
  describe "registro page" do
    let(:vendedor) { FactoryGirl.create(:vendedor) }
    before do
      log_in vendedor
      visit registro_path 
    end

    let(:submit) { "Crear cuenta" }

    describe "with invalid info" do
      it "should not create a user" do
        expect { click_button submit }.not_to change(Usuario, :count)
      end
    end

    describe "with valid info" do
      before do
        fill_in "Nombre",   with: "Usuario"
        fill_in "Apellido",   with: "Ejemplo"
        fill_in "Email",   with: "usuario1@ejemplo.com"
        fill_in "Telefono",   with: "45612312"
        # fill_in "Password",   with: "foobar"
        # fill_in "Confirmar Password",   with: "foobar"
      end

      it "should create a user" do
        expect { click_button submit }.to change(Usuario, :count).by(1)
      end

      describe "after saving the user" do
        before do
          click_button submit
        end
        let(:usuario) { Usuario.find_by_email("usuario1@ejemplo.com") }

        it { should have_selector('title', text: usuario.nombre) }
        # it { should have_link('Salir', href: logout_path) }
      end
    end
  end

  describe "edit" do
    let(:usuario) { FactoryGirl.create(:usuario) }
    before do
      log_in usuario
      visit edit_usuario_path(usuario)
    end

    describe "page" do
      it { should have_selector('title', text: "Editar perfil") }
      it { should have_button('Guardar datos') }
    end

    describe "with invalid info" do
      before { click_button 'Guardar datos' }
      it { should have_selector('title', text: "Editar") }
      # it { should have_content('error') }
    end

    describe "with valid info" do
      let(:new_name)  { "New Name" }
      let(:new_email) { "new@example.com" }
      before do
        fill_in "Nombre",               with: new_name
        fill_in "Apellido",             with: usuario.apellido
        fill_in "Email",                with: new_email
        fill_in "Telefono",             with: usuario.telefono
        fill_in "Password",             with: usuario.password
        fill_in "Confirmar Password",   with: usuario.password
        click_button "Guardar datos"
      end

      it { should have_selector('title', text: new_name) }
      it { should have_selector('div.alert.alert-success') }
      specify { usuario.reload.nombre.should  == new_name }
      specify { usuario.reload.email.should == new_email }
    end
  end    
end
  