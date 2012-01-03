Feature: Railschef Authentication Generator
	In order to authenticate users
	As a rails developer
	I want to generate some user authentication

	Scenario: Generate default authentication
		Given a new Rails app
		When I run rails g railschef:auth
		Then I should see the following files
			|  app/controllers/home_controller.rb  		        |   # create files
			|  app/views/home/index.html.erb 	     		        |   # create files
			|  app/controllers/sessions_controller.rb   		  |   # create files
			|  app/models/session.rb				                  |   # create files
			|  app/views/session/new.html.erb			            |   # create files
			|  app/models/user.rb				                      |   # create files
			|  app/controllers/users_controller.rb		        |   # create files
			|  db/migrate					                            |   # create files
			|  app/views/users/new.html.erb			              |   # create files
			|  app/views/users/_user.html.erb			            |   # create files
			|  app/views/users/edit.html.erb			            |   # create files
			|  lib/authentication.rb				                  |   # create files
			|  app/mailers/notifier.rb				                |   # create files
			|  app/views/notifier/activation_instructions.erb	|   # create files
			|  app/views/notifier/activation_confirmation.erb	|   # create files
			|  app/views/sessions/forgot_password.html.erb	  |   # create files
			|  app/views/users/reset_password.html.erb	      |   # create files
			|  app/views/notifier/forgot_password.html.erb	  |   # create files

		And I should see "gem "authlogic", "~>3.1.0"" in file "Gemfile"
		And I should not see the following file
			|  public/index.html				                      |   # remove files

		And I should see the following in file "config/routes.rb"
			|  get 'home/index'				                              |
			|  root :to => 'home#index'			                        |
			|  resources :sessions				                          |
			|  match 'login' => 'sessions#new', :as => :login	      |
			|  match 'logout' => 'sessions#destroy', :as => :logout |
			|  resources :account, :controller => "users"	          |
			|  resources :users				                              |
			|  match 'activate(/:activation_code)' => 'users#activate', :as => :activate_account                                   |
			|  match 'send_activation(/:user_id)' => 'users#send_activation', :as => :send_activation                              |
			|  match 'forgot_password' => 'sessions#forgot_password', :as => :forgot_password, :via => [:get, :post]               |
			|  match 'reset_password/:reset_password_code' => 'users#reset_password', :as => :reset_password, :via => [:get, :put] |

		And I should see "include Authentication" inside class "ApplicationController" in file "app/controllers/application_controller.rb"
		And I should see "config.autoload_paths << \"\#{config.root}/lib\"" inside class "Application" in file "config/application.rb"

