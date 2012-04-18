# Digital Island

  Estado Beta

## Taller

Control de Usuarios y los trabajos (items) que dejan

    - cliente:  no puede registrarse
                puede ver y hacer update sus datos
                no puede ver y hacer update los datos de otros clientes o  usuarios
                no puede ver la lista de usuarios#index
                al primer login con password por defecto se redirecciona a su edit page,
                    y pueda personalizar su password -- to do

    - admin:    solo un administrado - por decidir
                puede eliminar usuarios
                no puede registrar clientes
                no puede ver y hacer update los datos de otros clientes o  usuarios,
                puede ver lista de usuarios#index

    - tecnico:  puede registrar clientes - sin password
                puede ver lista de usuarios#index
                no puede ver y hacer update los datos de otros clientes o  usuarios
                no puede eliminar usuarios

    - vendedor: puede registrar clientes - sin password
                puede ver lista de usuarios#index
                no puede ver y hacer update los datos de otros clientes o  usuarios
                no puede eliminar usuarios




### PARAMETROS
    
    DEFAULT_PASSWORD = 'password'