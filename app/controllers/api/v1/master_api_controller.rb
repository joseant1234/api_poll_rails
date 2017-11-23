class Api::V1::MasterApiController < ApplicationController
	layout "api/v1/application"
	
	before_action :cors_set_access_control_headers
	before_action :authenticate_app, except: [:xhr_options_request]
	
	


	def cors_set_access_control_headers
		headers['Access-Control-Allow-Origin'] = "#{request.headers['origin']}"
		headers['Access-Control-Allow-Methods'] = "POST,GET,PUT,DELETE,OPTIONS"
		headers['Access-Control-Allow-Headers'] = 'Origin,Content-Type,Accept,Authorization,Token'

	end

	def xhr_options_request
		head :ok
	end

	private

	def authenticate_app
		if params.has_key?(:app_id)
			@my_app = MyApp.find_by(app_id: params[:app_id])
			if @my_app.nil? || !@my_app.is_valid_origin?(request.headers["origin"])
				error!("App ID inválido u origen incorrecto",:unauthorized)
			end
		elsif params.has_key?(:secret_key)
			@my_app = MyApp.find_by(secret_key: params[:secret_key])
			if @my_app.nil?
				error!("Secret key inválido",:unauthorized)
			end
		else
			error!("Necesitas una aplicación para comunicarte con el API", :unauthorized)
		end
	end

end