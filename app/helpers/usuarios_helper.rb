module UsuariosHelper

  def rol(usuario)
    return "cliente" if usuario.cliente?
    return "vendedor" if usuario.vendedor?
    return "tecnico" if usuario.tecnico?
  end
end
