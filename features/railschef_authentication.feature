Feature: Railschef Authentication Generator
  In order to authenticate users
  As a rails developer
  I want to generate some user authentication

  Scenario: Generate default authentication
    Given a new Rails app
    When I insert "gem 'therubyracer'" into "Gemfile" after line 20
    Then I should successfully run "bundle install"

    When I run "rails g railschef:auth"
    Then I should see the following files
      | app/controllers/home_controller.rb             |
      | app/controllers/sessions_controller.rb         |
      | app/controllers/users_controller.rb            |
      | app/models/session.rb                          |
      | app/models/user.rb                             |
      | app/views/home/index.html.erb                  |
      | app/views/sessions/new.html.erb                |
      | app/views/sessions/forgot_password.html.erb    |
      | app/views/users/new.html.erb                   |
      | app/views/users/_user.html.erb                 |
      | app/views/users/edit.html.erb                  |
      | app/views/users/reset_password.html.erb        |
      | app/views/notifier/activation_instructions.erb |
      | app/views/notifier/activation_confirmation.erb |
      | app/views/notifier/forgot_password.erb         |
      | app/mailers/notifier.rb                        |
      | lib/authentication.rb                          |
      | db/migrate                                     |
    And I should see "gem "authlogic", "~>3.1.0"" in file "Gemfile"
    And I should not see the following files
      | public/index.html                              |
    And I should see the following in file "config/routes.rb"
      | get 'home/index'                                     |
      | root :to => 'home#index'                             |
      | resources :sessions                                  |
      | resources :users                                     |
      | resource :account, :controller => "users"            |
      | match 'login' => 'sessions#new',      :as => :login  |
      | match 'logout' => 'sessions#destroy', :as => :logout |
      | match 'activate(/:activation_code)' => 'users#activate', :as => :activate_account                                   |
      | match 'send_activation(/:user_id)' => 'users#send_activation', :as => :send_activation                              |
      | match 'forgot_password' => 'sessions#forgot_password', :as => :forgot_password, :via => [:get, :post]               |
      | match 'reset_password/:reset_password_code' => 'users#reset_password', :as => :reset_password, :via => [:get, :put] |
    And I should see "include Authentication" in file "app/controllers/application_controller.rb"
    And I should see "config.autoload_paths << "#{config.root}/lib"" in file "config/application.rb"
    Then I should successfully run "bundle install"
    When I run "rails g railschef:layout -f"
    And I run "rake db:migrate"
    Then I should successfully run "rake test"

  Scenario: Generate named authentication
    Given a new Rails app
    When I insert "gem 'therubyracer'" into "Gemfile" after line 20
    Then I should successfully run "bundle install"

    When I run "rails g railschef:auth member"
    Then I should see the following files
      | app/controllers/home_controller.rb             |
      | app/controllers/sessions_controller.rb         |
      | app/controllers/members_controller.rb          |
      | app/models/session.rb                          |
      | app/models/member.rb                           |
      | app/views/home/index.html.erb                  |
      | app/views/sessions/forgot_password.html.erb    |
      | app/views/sessions/new.html.erb                |
      | app/views/members/new.html.erb                 |
      | app/views/members/_member.html.erb             |
      | app/views/members/edit.html.erb                |
      | app/views/members/reset_password.html.erb      |
      | app/views/notifier/activation_instructions.erb |
      | app/views/notifier/activation_confirmation.erb |
      | app/views/notifier/forgot_password.erb         |
      | app/mailers/notifier.rb                        |
      | lib/authentication.rb                          |
      | db/migrate                                     |
    And I should see "gem "authlogic", "~>3.1.0"" in file "Gemfile"
    And I should not see the following files
      | public/index.html                              |
    And I should see the following in file "config/routes.rb"
      | get 'home/index'                                     |
      | root :to => 'home#index'                             |
      | resources :sessions                                  |
      | resources :members                                   |
      | resource :account, :controller => "members"          |
      | match 'login' => 'sessions#new',      :as => :login  |
      | match 'logout' => 'sessions#destroy', :as => :logout |
      | match 'activate(/:activation_code)' => 'members#activate', :as => :activate_account                                   |
      | match 'send_activation(/:member_id)' => 'members#send_activation', :as => :send_activation                            |
      | match 'forgot_password' => 'sessions#forgot_password', :as => :forgot_password, :via => [:get, :post]                 |
      | match 'reset_password/:reset_password_code' => 'members#reset_password', :as => :reset_password, :via => [:get, :put] |
    And I should see "include Authentication" in file "app/controllers/application_controller.rb"
    And I should see "config.autoload_paths << "#{config.root}/lib"" in file "config/application.rb"
    Then I should successfully run "bundle install"
    When I run "rails g railschef:layout -f"
    And I run "rake db:migrate"
    Then I should successfully run "rake test"

  Scenario: Generate named and session named authentication
    Given a new Rails app
    When I insert "gem 'therubyracer'" into "Gemfile" after line 20
    Then I should successfully run "bundle install"

    When I run "rails g railschef:auth Member AccountSession"
    Then I should see the following files
      | app/controllers/home_controller.rb                  |
      | app/controllers/account_sessions_controller.rb      |
      | app/controllers/members_controller.rb               |
      | app/models/account_session.rb                       |
      | app/models/member.rb                                |
      | app/views/home/index.html.erb                       |
      | app/views/account_sessions/forgot_password.html.erb |
      | app/views/account_sessions/new.html.erb             |
      | app/views/members/new.html.erb                      |
      | app/views/members/_member.html.erb                  |
      | app/views/members/reset_password.html.erb           |
      | app/views/members/edit.html.erb                     |
      | app/views/notifier/activation_instructions.erb      |
      | app/views/notifier/activation_confirmation.erb      |
      | app/views/notifier/forgot_password.erb              |
      | app/mailers/notifier.rb                             |
      | lib/authentication.rb                               |
      | db/migrate                                          |
    And I should see "gem "authlogic", "~>3.1.0"" in file "Gemfile"
    And I should not see the following files
      | public/index.html                                    |
    And I should see the following in file "config/routes.rb"
      | get 'home/index'                                             |
      | root :to => 'home#index'                                     |
      | resources :account_sessions                                  |
      | resources :members                                           |
      | resource :account, :controller => "members"                  |
      | match 'login' => 'account_sessions#new',      :as => :login  |
      | match 'logout' => 'account_sessions#destroy', :as => :logout |
      | match 'activate(/:activation_code)' => 'members#activate', :as => :activate_account                                   |
      | match 'send_activation(/:member_id)' => 'members#send_activation', :as => :send_activation                            |
      | match 'forgot_password' => 'account_sessions#forgot_password', :as => :forgot_password, :via => [:get, :post]         |
      | match 'reset_password/:reset_password_code' => 'members#reset_password', :as => :reset_password, :via => [:get, :put] |
    And I should see "include Authentication" in file "app/controllers/application_controller.rb"
    And I should see "config.autoload_paths << "#{config.root}/lib"" in file "config/application.rb"
    Then I should successfully run "bundle install"
    When I run "rails g railschef:layout -f"
    And I run "rake db:migrate"
    Then I should successfully run "rake test"

  Scenario: Generate named, session named and account named authentication
    Given a new Rails app
    When I insert "gem 'therubyracer'" into "Gemfile" after line 20
    Then I should successfully run "bundle install"

    When I run "rails g railschef:auth Member AccountSession Usher"
    Then I should see the following files
      | app/controllers/home_controller.rb                  |
      | app/controllers/account_sessions_controller.rb       |
      | app/controllers/members_controller.rb               |
      | app/models/account_session.rb                        |
      | app/models/member.rb                                |
      | app/views/home/index.html.erb                       |
      | app/views/account_sessions/forgot_password.html.erb  |
      | app/views/account_sessions/new.html.erb              |
      | app/views/members/new.html.erb                      |
      | app/views/members/_member.html.erb                  |
      | app/views/members/reset_password.html.erb           |
      | app/views/members/edit.html.erb                     |
      | app/views/notifier/activation_instructions.erb      |
      | app/views/notifier/activation_confirmation.erb      |
      | app/views/notifier/forgot_password.erb              |
      | app/mailers/notifier.rb                             |
      | lib/authentication.rb                               |
      | db/migrate                                          |
    And I should see "gem "authlogic", "~>3.1.0"" in file "Gemfile"
    And I should see "Usher" in file "app/views/home/index.html.erb"
    And I should not see the following files
      | public/index.html                                   |
    And I should see the following in file "config/routes.rb"
      | get 'home/index'                                            |
      | root :to => 'home#index'                                    |
      | resources :account_sessions                                  |
      | match 'login' => 'account_sessions#new',      :as => :login  |
      | match 'logout' => 'account_sessions#destroy', :as => :logout |
      | resource :Usher, :controller => "members"                   |
      | resources :members                                          |
      | match 'activate(/:activation_code)' => 'members#activate', :as => :activate_account                           |
      | match 'send_activation(/:member_id)' => 'members#send_activation', :as => :send_activation                    |
      | match 'forgot_password' => 'account_sessions#forgot_password', :as => :forgot_password, :via => [:get, :post]  |
    Then I should successfully run "bundle install"
    When I run "rails g railschef:layout -f"
    And I run "rake db:migrate"
    Then I should successfully run "rake test"

  Scenario: Generate default omniauth authentication
    Given a new Rails app
    When I insert "gem 'therubyracer'" into "Gemfile" after line 20
    Then I should successfully run "bundle install"

    When I run "rails g railschef:auth --omniauth"
    Then I should see the following files
      | app/controllers/home_controller.rb             |
      | app/controllers/sessions_controller.rb         |
      | app/controllers/users_controller.rb            |
      | app/models/session.rb                          |
      | app/models/user.rb                             |
      | app/views/home/index.html.erb                  |
      | app/views/sessions/new.html.erb                |
      | app/views/sessions/forgot_password.html.erb    |
      | app/views/users/new.html.erb                   |
      | app/views/users/_user.html.erb                 |
      | app/views/users/edit.html.erb                  |
      | app/views/users/reset_password.html.erb        |
      | app/views/notifier/activation_instructions.erb |
      | app/views/notifier/activation_confirmation.erb |
      | app/views/notifier/forgot_password.erb         |
      | app/mailers/notifier.rb                        |
      | lib/authentication.rb                          |
    # Omniauth
      | config/initializers/omniauth.rb                |
      | app/models/omni_provider.rb                    |
      | app/controllers/omni_providers_controller.rb   |
      | app/views/users/_omni_providers.html.erb       |
      | db/migrate                                     |
    And I should see "gem "authlogic", "~>3.1.0"" in file "Gemfile"
    And I should see "gem "omniauth", "~>1.0.0"" in file "Gemfile"
    And I should not see the following files
      | public/index.html                               |
    And I should see the following in file "config/routes.rb"
      | get 'home/index'                                     |
      | root :to => 'home#index'                             |
      | resources :sessions                                  |
      | resources :users                                     |
      | resource :account, :controller => "users"            |
      | match 'login' => 'sessions#new',      :as => :login  |
      | match 'logout' => 'sessions#destroy', :as => :logout |
      | match 'activate(/:activation_code)' => 'users#activate', :as => :activate_account                                   |
      | match 'send_activation(/:user_id)' => 'users#send_activation', :as => :send_activation                              |
      | match 'forgot_password' => 'sessions#forgot_password', :as => :forgot_password, :via => [:get, :post]               |
      | match 'reset_password/:reset_password_code' => 'users#reset_password', :as => :reset_password, :via => [:get, :put] |
    # Omniauth
      | resources :omni_providers                                     |
      | match '/auth/:provider/callback', to: 'omni_providers#create' |
    And I should see "include Authentication" in file "app/controllers/application_controller.rb"
    And I should see "config.autoload_paths << "#{config.root}/lib"" in file "config/application.rb"

    # <%- if options.omniauth? -%>                                                             controllers, models and migration
    And I should see "assign_omniauth" in file "lib/authentication.rb"
    And I should see "apply_omniauth" in file "app/models/user.rb"
    And I should see "omni_providers" in file "app/models/user.rb"

    # <%- if options.omniauth? -%> views
    And I should see "Developer" in file "app/views/sessions/new.html.erb"
    And I should see "omni_provider" in file "app/views/users/edit.html.erb"

    Then I should successfully run "bundle install"
    When I run "rails g railschef:layout -f"
    And I run "rake db:migrate"
    Then I should successfully run "rake test"

  Scenario: Generate default skip home authentication
    Given a new Rails app
    When I insert "gem 'therubyracer'" into "Gemfile" after line 20
    Then I should successfully run "bundle install"

    When I run "rails g railschef:auth --skip-home"
    Then I should see the following files
      | app/controllers/sessions_controller.rb         |
      | app/controllers/users_controller.rb            |
      | app/models/session.rb                          |
      | app/models/user.rb                             |
      | app/views/sessions/new.html.erb                |
      | app/views/sessions/forgot_password.html.erb    |
      | app/views/users/new.html.erb                   |
      | app/views/users/_user.html.erb                 |
      | app/views/users/edit.html.erb                  |
      | app/views/users/reset_password.html.erb        |
      | app/views/notifier/activation_instructions.erb |
      | app/views/notifier/activation_confirmation.erb |
      | app/views/notifier/forgot_password.erb         |
      | app/mailers/notifier.rb                        |
      | lib/authentication.rb                          |
      | db/migrate                                     |
    And I should see "gem "authlogic", "~>3.1.0"" in file "Gemfile"
    And I should not see the following files
      | public/index.html                              |
      | app/controllers/home_controller.rb             |
      | app/views/home/index.html.erb                  |
    And I should see the following in file "config/routes.rb"
      | resources :sessions                                  |
      | resources :users                                     |
      | resource :account, :controller => "users"            |
      | match 'login' => 'sessions#new',      :as => :login  |
      | match 'logout' => 'sessions#destroy', :as => :logout |
      | match 'activate(/:activation_code)' => 'users#activate', :as => :activate_account                                   |
      | match 'send_activation(/:user_id)' => 'users#send_activation', :as => :send_activation                              |
      | match 'forgot_password' => 'sessions#forgot_password', :as => :forgot_password, :via => [:get, :post]               |
      | match 'reset_password/:reset_password_code' => 'users#reset_password', :as => :reset_password, :via => [:get, :put] |
    And I should see "include Authentication" in file "app/controllers/application_controller.rb"
    And I should see "config.autoload_paths << "#{config.root}/lib"" in file "config/application.rb"
    Then I should successfully run "bundle install"

    And I should not see the following in file "config/routes.rb"
      | get 'home/index'                                     |
      | root :to => 'home#index'                             |

    When I run "rails g railschef:layout -f"
    And I run "rake db:migrate"
    Then I should successfully run "rake test"

  Scenario: Generate default login name custome authentication
    Given a new Rails app
    When I insert "gem 'therubyracer'" into "Gemfile" after line 20
    Then I should successfully run "bundle install"

    When I run "rails g railschef:auth --login-name=enter"
    Then I should see the following files
      | app/controllers/home_controller.rb             |
      | app/controllers/sessions_controller.rb         |
      | app/controllers/users_controller.rb            |
      | app/models/session.rb                          |
      | app/models/user.rb                             |
      | app/views/home/index.html.erb                  |
      | app/views/sessions/new.html.erb                |
      | app/views/sessions/forgot_password.html.erb    |
      | app/views/users/new.html.erb                   |
      | app/views/users/_user.html.erb                 |
      | app/views/users/edit.html.erb                  |
      | app/views/users/reset_password.html.erb        |
      | app/views/notifier/activation_instructions.erb |
      | app/views/notifier/activation_confirmation.erb |
      | app/views/notifier/forgot_password.erb         |
      | app/mailers/notifier.rb                        |
      | lib/authentication.rb                          |
      | db/migrate                                     |
    And I should see "gem "authlogic", "~>3.1.0"" in file "Gemfile"
    And I should not see the following files
      | public/index.html                               |
    And I should see the following in file "config/routes.rb"
      | get 'home/index'                                     |
      | root :to => 'home#index'                             |
      | resources :sessions                                  |
      | resources :users                                     |
      | resource :account, :controller => "users"            |
      | match 'enter' => 'sessions#new',      :as => :enter  |
      | match 'logout' => 'sessions#destroy', :as => :logout |
      | match 'activate(/:activation_code)' => 'users#activate', :as => :activate_account                                   |
      | match 'send_activation(/:user_id)' => 'users#send_activation', :as => :send_activation                              |
      | match 'forgot_password' => 'sessions#forgot_password', :as => :forgot_password, :via => [:get, :post]               |
      | match 'reset_password/:reset_password_code' => 'users#reset_password', :as => :reset_password, :via => [:get, :put] |
    And I should see "include Authentication" in file "app/controllers/application_controller.rb"
    And I should see "config.autoload_paths << "#{config.root}/lib"" in file "config/application.rb"
    Then I should successfully run "bundle install"

    When I run "rails g railschef:layout -f"
    And I run "rake db:migrate"
    Then I should successfully run "rake test"

  Scenario: Generate default logout name custome authentication
    Given a new Rails app
    When I insert "gem 'therubyracer'" into "Gemfile" after line 20
    Then I should successfully run "bundle install"

    When I run "rails g railschef:auth --logout-name=quit"
    Then I should see the following files
      | app/controllers/home_controller.rb             |
      | app/controllers/sessions_controller.rb         |
      | app/controllers/users_controller.rb            |
      | app/models/session.rb                          |
      | app/models/user.rb                             |
      | app/views/home/index.html.erb                  |
      | app/views/sessions/new.html.erb                |
      | app/views/sessions/forgot_password.html.erb    |
      | app/views/users/new.html.erb                   |
      | app/views/users/_user.html.erb                 |
      | app/views/users/edit.html.erb                  |
      | app/views/users/reset_password.html.erb        |
      | app/views/notifier/activation_instructions.erb |
      | app/views/notifier/activation_confirmation.erb |
      | app/views/notifier/forgot_password.erb         |
      | app/mailers/notifier.rb                        |
      | lib/authentication.rb                          |
      | db/migrate                                     |
    And I should see "gem "authlogic", "~>3.1.0"" in file "Gemfile"
    And I should not see the following files
      | public/index.html                              |
    And I should see the following in file "config/routes.rb"
      | get 'home/index'                                     |
      | root :to => 'home#index'                             |
      | resources :sessions                                  |
      | resources :users                                     |
      | resource :account, :controller => "users"            |
      | match 'login' => 'sessions#new',      :as => :login  |
      | match 'quit' => 'sessions#destroy', :as => :quit     |
      | match 'activate(/:activation_code)' => 'users#activate', :as => :activate_account                                   |
      | match 'send_activation(/:user_id)' => 'users#send_activation', :as => :send_activation                              |
      | match 'forgot_password' => 'sessions#forgot_password', :as => :forgot_password, :via => [:get, :post]               |
      | match 'reset_password/:reset_password_code' => 'users#reset_password', :as => :reset_password, :via => [:get, :put] |
    And I should see "include Authentication" in file "app/controllers/application_controller.rb"
    And I should see "config.autoload_paths << "#{config.root}/lib"" in file "config/application.rb"
    Then I should successfully run "bundle install"

    When I run "rails g railschef:layout -f"
    And I run "rake db:migrate"
    Then I should successfully run "rake test"

