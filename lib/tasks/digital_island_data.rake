namespace :db do
  desc "Llenar la base de datos con datos de ejemplo"
  task populate: :environment do
    admin = Usuario.create(nombre: "Usuario",
                           apellido: "Admin",
                           email: "admin@island.com",
                           telefono: "4550859",
                           password: "foobar",
                           password_confirmation: "foobar")
    admin.toggle!(:cliente)
    admin.toggle!(:admin)

    tecnico = Usuario.create(nombre: "Usuario",
                             apellido: "Tecnico",
                             email: "tecnico@island.com",
                             telefono: "4550859",
                             password: "foobar",
                             password_confirmation: "foobar")
    tecnico.toggle!(:cliente)
    tecnico.toggle!(:tecnico)

    vendedor = Usuario.create(nombre: "Usuario",
                              apellido: "Vendedor",
                              email: "vendedor@island.com",
                              telefono: "4550859",
                              password: "foobar",
                              password_confirmation: "foobar")
    vendedor.toggle!(:cliente)
    vendedor.toggle!(:vendedor)

    12.times do |n|
      nombre = Faker::Name.first_name
      apellido = Faker::Name.last_name
      email = "cliente#{n}@island.com"
      telefono = "00000#{n}"
      password = "foobar"
      Usuario.create(nombre: nombre,
                     apellido: apellido,
                     email: email,
                     telefono: telefono,
                     password: password,
                     password_confirmation: password)
    end
  end
end