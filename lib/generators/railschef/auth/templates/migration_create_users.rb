class Create<%= user_class_name.pluralize %> < ActiveRecord::Migration
  def self.up
    create_table :<%= user_plural_name %> do |t|
      t.string    :login,               :null => false
      t.string    :email,               :null => false
      t.string    :crypted_password,    :null => false
      t.string    :password_salt,       :null => false
      t.string    :persistence_token,   :null => false
      <%- if options.omniauth? -%>
      t.string    :single_access_token, :null => false                # optional, see Authlogic::Session::Params
      <%- end -%>
      t.string    :perishable_token,    :null => false                # optional, see Authlogic::Session::Perishability

      # magic fields (all optional, see Authlogic::Session::MagicColumns)
      t.integer   :login_count,         :null => false, :default => 0
      t.integer   :failed_login_count,  :null => false, :default => 0
      t.datetime  :last_request_at
      t.datetime  :current_login_at
      t.datetime  :last_login_at
      t.string    :current_login_ip
      t.string    :last_login_ip
      t.boolean   :active,              :default => false
      t.timestamps
    end

    add_index :<%= user_plural_name %>, ['login'], :name => "index_<%= user_plural_name %>_on_login", :unique => true
    add_index :<%= user_plural_name %>, ['email'], :name => "index_<%= user_plural_name %>_on_email", :unique => true
    add_index :<%= user_plural_name %>, ['persistence_token'], :name => "index_<%= user_plural_name %>_on_persistence_token", :unique => true
  end

  def self.down
    drop_table :<%= user_plural_name %>
  end
end

