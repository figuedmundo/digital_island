class ApplicationController < ActionController::Base
  protect_from_forgery

  include SessionsHelper

  DEFAULT_PASSWORD = 'password'
end
