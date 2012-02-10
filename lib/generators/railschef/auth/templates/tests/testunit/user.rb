require 'test_helper'

class <%= user_class_name %>Test < ActiveSupport::TestCase
  <%- if options.omniauth? -%>
  def new_<%= user_singular_name %>(attributes = {})
    attributes[:login] ||= 'foo'
    attributes[:email] ||= 'foo@example.com'
    attributes[:crypted_password] ||= '3d16c326648cccafe3d4b4cb024475c381dda92f430dfedf6f933e1f61203bacb6bae2437849bdb43b06be335e23790e4aa03902b3c28c3bbbbe27d501e521f3'
    attributes[:password_salt] ||= 'n6z_wtpWoIsHgQb5IcFd'
    attributes[:persistence_token] ||= 'd5ddba13ed4408ea2b0a12ab18ed2d2eda086279736bdc121ca726a11f1e4b99217d9c534c2cc4ebb22729349c8c5fdbe1529e1f2c3c5859c62ef4dd9feea25c'
    attributes[:perishable_token] ||= 'VyiXHtZ4HsFS62xCnK4I'
    attributes[:single_access_token] ||= 'DRpWcgGItsXPcvCOVctZGhSLQPXLvuIhDoXXaW5Oopt53uFsZssT8CeIoCzZxSX'
    attributes[:active] ||= true
    <%= user_singular_name %> = <%= user_class_name %>.new(attributes)
    <%= user_singular_name %>.valid? # run validations
    <%= user_singular_name %>
  end
  <%- else -%>
  def new_<%= user_singular_name %>(attributes = {})
    attributes[:login] ||= 'foo'
    attributes[:email] ||= 'foo@example.com'
    attributes[:crypted_password] ||= '3d16c326648cccafe3d4b4cb024475c381dda92f430dfedf6f933e1f61203bacb6bae2437849bdb43b06be335e23790e4aa03902b3c28c3bbbbe27d501e521f3'
    attributes[:password_salt] ||= 'n6z_wtpWoIsHgQb5IcFd'
    attributes[:persistence_token] ||= 'd5ddba13ed4408ea2b0a12ab18ed2d2eda086279736bdc121ca726a11f1e4b99217d9c534c2cc4ebb22729349c8c5fdbe1529e1f2c3c5859c62ef4dd9feea25c'
    attributes[:perishable_token] ||= 'VyiXHtZ4HsFS62xCnK4I'
    attributes[:active] ||= true
    <%= user_singular_name %> = <%= user_class_name %>.new(attributes)
    <%= user_singular_name %>.valid? # run validations
    <%= user_singular_name %>
  end
  <%- end -%>
end

