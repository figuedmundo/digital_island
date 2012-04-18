# == Schema Information
#
# Table name: usuarios
#
#  id              :integer         not null, primary key
#  nombre          :string(255)
#  apellido        :string(255)
#  email           :string(255)
#  telefono        :string(255)
#  created_at      :datetime        not null
#  updated_at      :datetime        not null
#  password_digest :string(255)
#  remember_token  :string(255)
#  admin           :boolean         default(FALSE)
#  tecnico         :boolean         default(FALSE)
#  vendedor        :boolean         default(FALSE)
#  cliente         :boolean         default(TRUE)
#

require 'spec_helper'

describe Usuario do
  
  before { @usuario = Usuario.new(nombre: "Usuario", apellido: "Ejemplo", 
                                  email: "usuario@ejemplo.com", telefono: "4550259",
                                  password: "foobar", password_confirmation: "foobar" ) }
  subject { @usuario }
  
  it { should respond_to(:nombre) }
  it { should respond_to(:apellido) }
  it { should respond_to(:email) }
  it { should respond_to(:telefono) }
  it { should respond_to(:password_digest) }
  it { should respond_to(:password) }
  it { should respond_to(:password_confirmation) }
  it { should respond_to(:authenticate) }
  it { should respond_to(:remember_token) }
  it { should respond_to(:admin) }
  it { should respond_to(:tecnico) }
  it { should respond_to(:vendedor) }
  it { should respond_to(:cliente) }
  it { should respond_to(:created_by) }


  it { should be_valid }

  

  describe "when nombre is blank" do
    before { @usuario.nombre = "  " }

    it { should_not be_valid }
  end

  describe "when apellido is blank" do
    before { @usuario.apellido = "  " }

    it { should_not be_valid }
  end

  describe "when email is blank" do
    before { @usuario.email = "  " }

    it { should_not be_valid }
  end

  describe "when telefono is blank" do
    before { @usuario.telefono = "  " }

    it { should_not be_valid }
  end

  describe "when telefono is invalid" do
    before { @usuario.telefono = "invalido" }
    it { should_not be_valid }
  end

  describe "when email is duplicate" do
    before do
      usuario_nuevo = @usuario.dup
      usuario_nuevo.email = @usuario.email.upcase
      usuario_nuevo.save
    end

    it { should_not be_valid }
  end

  describe "password too short" do
    before { @usuario.password = @usuario.password_confirmation = "a"*5 }
    it { should_not be_valid }
  end

  describe "when password doesn't match confirmation" do
     before { @usuario.password_confirmation = "mismatch" }
     it { should_not be_valid }
  end

  describe "when password confirmation is nil" do
     before { @usuario.password_confirmation = nil }
     it { should_not be_valid }
  end

  describe "rememeber token" do
    before { @usuario.save }
    its(:remember_token) { should_not be_blank }
  end
end
