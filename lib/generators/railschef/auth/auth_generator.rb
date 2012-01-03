require 'generators/railschef'
require 'rails/generators/migration'

module Railschef
  module Generators
    class AuthGenerator < Base
      include Rails::Generators::Migration

      argument :user_name, :type => :string, :default => 'user', :banner => 'user_name'
      argument :session_name, :type => :string, :default => 'session', :banner => "session_name"
      argument :account_name, :type => :string, :default => 'account', :banner => 'account_name'

      class_option :login_name, :desc => "Login name.", :default => "login", :type => :string
      class_option :logout_name, :desc => "Logout name.", :default => "logout", :type => :string

      class_option :skip_home, :type => :boolean,
        :desc => "Skip generate home controller, view and routes. Just make sure to provide route for root."
      class_option :omniauth, :type => :boolean,
        :desc => "Integrate OmniAuth with Authlogic."

      def add_gems
        log_info "Add gems"
        add_gem "authlogic", :version => "~>3.1.0"
        add_gem "omniauth",  :version => "~>1.0.0" if options.omniauth?
      end

      def remove_index_if_exist
        log_info "Remove default index page if exist"
        remove_file("public/index.html")
      end

      def create_home_files
        unless options.skip_home?
          log_info "Create home files"
          template "controllers_home.rb", "app/controllers/home_controller.rb"
          template "views/home_index.html.erb", "app/views/home/index.html.erb"
          route("get 'home/index'")
          route("root :to => 'home#index'")
        end
      end

      def create_session_files
        log_info "Create #{session_singular_name} files"
        template "controllers_sessions.rb", "app/controllers/#{session_plural_name}_controller.rb"
        template "models_session.rb", "app/models/#{session_singular_name}.rb"
        template "views/sessions_new.html.erb", "app/views/#{session_plural_name}/new.html.erb"
        route("resources :#{session_plural_name}")
        route("match '#{login_name}' => '#{session_plural_name}#new',      :as => :#{login_name}")
        route("match '#{logout_name}' => '#{session_plural_name}#destroy', :as => :#{logout_name}")
      end

      def create_user_files
        log_info "Create #{user_singular_name} files"
        template "models_user.rb", "app/models/#{user_singular_name}.rb"
        template "controllers_users.rb", "app/controllers/#{user_plural_name}_controller.rb"
        migration_template 'migration_create_users.rb', "db/migrate/create_#{user_plural_name}.rb"
        template "views/users_new.html.erb", "app/views/#{user_plural_name}/new.html.erb"
        template "views/users__user.html.erb", "app/views/#{user_plural_name}/_#{user_singular_name}.html.erb"
        template "views/users_edit.html.erb", "app/views/#{user_plural_name}/edit.html.erb"
        route("resource :#{account_name}, :controller => \"#{user_plural_name}\"")
        route("resources :#{user_plural_name}")
      end

      def create_lib_files
        log_info "Create lib files"
        template 'lib_authentication.rb', 'lib/authentication.rb'
      end

      def load_and_include_authentication
        log_info "Load and include Authentication"
        inject_into_class "config/application.rb", "Application", " config.autoload_paths << \"\#{config.root}/lib\""
        inject_into_class "app/controllers/application_controller.rb", "ApplicationController", "  include Authentication\n"
      end

      def create_notifier_files
        log_info "Create notifier files"
        template "mailers_notifier.rb", "app/mailers/notifier.rb"
      end

      def create_activation_files
        log_info "Create activation files"
        template "views/notifier_activation_instructions.erb", "app/views/notifier/activation_instructions.erb"
        template "views/notifier_activation_confirmation.erb", "app/views/notifier/activation_confirmation.erb"
        route("match 'activate(/:activation_code)' => '#{user_plural_name}#activate', :as => :activate_account")
        route("match 'send_activation(/:#{user_singular_name}_id)' => '#{user_plural_name}#send_activation', :as => :send_activation")
      end

      def create_forgot_password_files
        log_info "Create forgot password files"
        template "views/sessions_forgot_password.html.erb", "app/views/#{session_plural_name}/forgot_password.html.erb"
        template "views/users_reset_password.html.erb", "app/views/#{user_plural_name}/reset_password.html.erb"
        template "views/notifier_forgot_password.erb", "app/views/notifier/forgot_password.erb"
        route("match 'forgot_password' => '#{session_plural_name}#forgot_password', :as => :forgot_password, :via => [:get, :post]")
        route("match 'reset_password/:reset_password_code' => '#{user_plural_name}#reset_password', :as => :reset_password, :via => [:get, :put]")
      end

      def create_omniauth_files
        if options.omniauth?
          log_info "Create omniauth files"
          template "config/initializers_omniauth.rb", "config/initializers/omniauth.rb"
          template "models_omni_provider.rb", "app/models/omni_provider.rb"
          template "controllers_omni_providers.rb", "app/controllers/omni_providers_controller.rb"
          template "views/users__omni_providers.html.erb", "app/views/#{user_plural_name}/_omni_providers.html.erb"
          # FIXME: Quick fix for identical migration number for the second migration
          # Need to find another way to do this, e.g. search if the number exist or not
          sleep 1
          migration_template 'migration_create_omni_providers.rb', "db/migrate/create_omni_providers.rb"
          route("resources :omni_providers")
          route("match '/auth/:provider/callback', to: 'omni_providers#create'")
        end
      end

    private
      def user_singular_name
        user_name.underscore
      end

      def user_plural_name
        user_singular_name.pluralize
      end

      def user_class_name
        user_name.camelize
      end

      def session_singular_name
        session_name.underscore
      end

      def session_plural_name
        session_singular_name.pluralize
      end

      def session_class_name
        session_name.camelize
      end

      def login_name
        options.login_name
      end

      def logout_name
        options.logout_name
      end

      def login_name_title
        login_name.titleize
      end

      def logout_name_title
        logout_name.titleize
      end

      def self.next_migration_number(dirname) #:nodoc:
        if ActiveRecord::Base.timestamped_migrations
          Time.now.utc.strftime("%Y%m%d%H%M%S")
        else
          "%.3d" % (current_migration_number(dirname) + 1)
        end
      end
    end
  end
end

