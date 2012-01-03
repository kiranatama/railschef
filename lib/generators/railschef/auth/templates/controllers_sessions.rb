class <%= session_class_name.pluralize %>Controller < ApplicationController
  before_filter :require_no_<%= user_singular_name %>, :only => [:new, :create]
  before_filter :require_<%= user_singular_name %>, :only => :destroy
  before_filter :redirect_to_edit_if_logged_in, :only => [:forgot_password, :forgot_password_lookup_email]

  def new
    @<%= session_singular_name %> = <%= session_class_name %>.new
  end

  def create
    @<%= session_singular_name %> = <%= session_class_name %>.new(params[:<%= session_singular_name %>])
    if @<%= session_singular_name %>.save
      flash[:notice] = "<%= login_name_title %> successful!"
      redirect_back_or_default root_path
    else
      render :action => :new
    end
  end

  def destroy
    current_<%= session_singular_name %>.destroy
    flash[:notice] = "<%= logout_name_title %> successful!"
    redirect_to <%= login_name %>_url
  end

  def forgot_password
    redirect_to edit_<%= user_singular_name %>_url and return if current_<%= user_singular_name %>

    unless params[:<%= session_singular_name %>]
      @<%= session_singular_name %> = <%= session_class_name %>.new()
      return
    end

    <%= user_singular_name %> = <%= user_class_name %>.find_by_email(params[:<%= session_singular_name %>][:email])
    if <%= user_singular_name %>
      <%= user_singular_name %>.send_forgot_password!
      flash[:notice] = "A link to reset your password has been mailed to you."
    else
      flash[:notice] = "Email #{params[:<%= session_singular_name %>][:email]}  wasn't found.  Perhaps you used a different one?  Or never registered or something?"
    end
  end

  def forgot_password_lookup_email
    <%= user_singular_name %> = <%= user_class_name %>.find_by_email(params[:<%= session_singular_name %>][:email])
    if <%= user_singular_name %>
      <%= user_singular_name %>.send_forgot_password!
      flash[:notice] = "A link to reset your password has been mailed to you."
    else
      flash[:notice] = "Email #{params[:<%= session_singular_name %>][:email]}  wasn't found.  Perhaps you used a different one?  Or never registered or something?"
      render :action => :forgot_password
    end
  end

private
  def redirect_to_edit_if_logged_in
    if current_<%= user_singular_name %>
      redirect_to edit_<%= user_singular_name %>_url and return
    end
  end
end

