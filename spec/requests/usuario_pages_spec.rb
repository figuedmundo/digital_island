require 'spec_helper'

describe "Usuario Pages" do
  subject { page }

  describe "index page" do
    before { visit root_path }
              
    it { should have_selector('title', text: "Usuarios") }
  end

  describe "show(usuario) page" do
    let(:usuario) { FactoryGirl.create(:usuario) }
    before { visit usuario_path(usuario) }

    it { should have_selector('title', text: usuario.nombre) }
    it { should have_selector('h1', text: usuario.nombre) }
  end
   
  describe "registro page" do
    before { visit registro_path }
    it { should have_selector('title', text: "Registro") }

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
        fill_in "Email",   with: "usuario@ejemplo.com"
        fill_in "Telefono",   with: "45612312"
        fill_in "Password",   with: "foobar"
        fill_in "Confirmar Password",   with: "foobar"
      end

      it "should create a user" do
        expect { click_button submit }.to change(Usuario, :count).by(1)
      end

      describe "after saving the user" do
        before do
          click_button submit
        end
        let(:usuario) { Usuario.find_by_email("usuario@ejemplo.com") }

        it { should have_selector('title', text: usuario.nombre) }
        it { should have_link('Salir', href: logout_path) }
      end
    end
  end

  describe "edit" do
    let(:usuario) { FactoryGirl.create(:usuario) }
    before { visit edit_usuario_path(usuario) }

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
  