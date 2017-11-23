module ApplicationHelper
	def user_signed_in?
		#Devolverá verdadero si hay un usuario logeado y falso si no hay usuario logeado
		!current_user.nil? # Devuelve verdadero si el objeto es nulo caso contrario devuelve falso
		
	end

	def current_user
		#Devolver nil si ningun usuario esta logeado o devolver el usuario que esta logeado
		User.where(id: session[:user_id]).first
	end
end
