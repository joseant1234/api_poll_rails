class ApplicationController < ActionController::Base
  
  include UserAuthentication

  #before_action :authenticate
  before_action :set_jbuilder_defaults

  protected
  
  def authenticate
  	token_str = params[:token]
  	token = Token.find_by(token: token_str)
    
  	if token.nil? or not token.is_valid? or not @my_app.is_your_token?(token)
      error!("Tu token es inválido", :unauthorized)
  	else
  		@current_user = token.user
  	end

  end

  def set_jbuilder_defaults
    @errors = []
  end

  def error!(message,status)
    @errors << message
    response.status = status
    render template: "api/v1/errors"
  end

  def error_array!(array,status)
    @errors = @errors + array
    response.status = status
    render "api/v1/errors"
  end

  def authenticate_owner(owner)
    if owner != @current_user
      render json: { errors: "No tienes autorizado editar este recurso" }, status: 401
    end
  end


end
