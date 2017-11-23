Rails.application.routes.draw do
  
  get "/", to: "welcome#app", constraints: lambda{|solicitud| !solicitud.session[:user_id].blank? }
  
  get "/", to: "welcome#index"
  

  resources :my_apps, except: [:show, :index]


  namespace :api, defaults: { format: "json"  } do
    namespace :v1 do
      resources :users, only: [:create]
      resources :polls, controller: "my_polls", except: [:new, :edit] do
      	resources :questions, except: [:new, :edit]
      	resources :answers, only: [:update,:destroy,:create]
      end      

      resources :my_answers, only: [:create]
      match "*unmatched", via: [:options], to: "master_api#xhr_options_request"
    end
  end

  

  get "/auth/:provider/callback", to: "sessions#create"


  delete "/logout", to: "sessions#destroy"

end