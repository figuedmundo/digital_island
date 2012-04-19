FactoryGirl.define do
  
  factory :usuario do
    nombre   "Usuario"
    apellido "Ejemplo"
    email    "usuario@ejemplo.com"
    telefono "79769505"
    password              "foobar"
    password_confirmation "foobar"

    factory :admin do
      admin true
      cliente false
    end

    factory :tecnico do
      tecnico true
      cliente false
    end

    factory :vendedor do
      vendedor true
      cliente false
    end
  end
  
  factory :item do
    detalle "Lorem ipsun"
    estado  "recibido"
    usuario
  end  
end