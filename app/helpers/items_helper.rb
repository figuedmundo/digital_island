module ItemsHelper

  def tecnicos
    tecnicos ||= Usuario.where("tecnico = ?",true)
    ( tecnicos.respond_to?(:map) ) ? tecnicos.map { |tecnico| tecnico.nombre_completo } : tecnico.nombre_completo
  end


end

private
  
  estados = ['recibido', 'revisado', 'listo', 'recogido']
