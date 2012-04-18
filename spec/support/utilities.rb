
def log_in(usuario)
  visit login_path

  fill_in "Email",   with: usuario.email
  fill_in "Password",   with: usuario.password
  click_button 'Entrar'
  
  cookies[:remember_token] = usuario.remember_token
end
