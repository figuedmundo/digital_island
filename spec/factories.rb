FactoryGirl.define do
  
  factory :usuario do
    nombre   "Usuario"
    apellido "Ejemplo"
    email    "usuario@ejemplo.com"
    telefono "79769505"
    password              "foobar"
    password_confirmation "foobar"
  end
  
end