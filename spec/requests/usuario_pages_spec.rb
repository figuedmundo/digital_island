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
    end
  end
end
  