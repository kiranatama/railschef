class <%= user_class_name.pluralize %>Controller < ApplicationController
  before_filter :require_no_<%= user_singular_name %>, :only => [:new, :create, :activate, :reset_password]
  before_filter :require_<%= user_singular_name %>, :only => [:edit, :update]
  before_filter :prepare_<%= user_singular_name %>, :only => [:edit, :update]

  def new
    @<%= user_singular_name %> = <%= user_class_name %>.new
  end

  def create
    @<%= user_singular_name %> = <%= user_class_name %>.new(params[:<%= user_singular_name %>])

    # Saving without session maintenance to skip
    # auto-login which can't happen here because
    # the <%= user_class_name %> has not yet been activated
    if @<%= user_singular_name %>.save_without_session_maintenance
      @<%= user_singular_name %>.send_activation_instructions!
      flash[:notice] = "Your account has been created. Please check your e-mail for your account activation instructions!"
      redirect_to <%= login_name %>_url
    else
      flash[:notice] = 'There was a problem creating the <%= user_singular_name %>'
      render :action => :new
    end
  end

  def edit
  end

  def update
    if @<%= user_singular_name %>.update_attributes(params[:<%= user_singular_name %>])
      flash[:notice] = "<%= user_class_name %> was successfully updated."
      redirect_to root_url
    else
      flash[:error] = "<%= user_class_name %> was failed to update."
      render :action => "edit"
    end
  end

  def activate
    @<%= user_singular_name %> = <%= user_class_name %>.find_using_perishable_token(params[:activation_code], 1.week) || (raise Exception)

    raise Exception if @<%= user_singular_name %>.active?

    if @<%= user_singular_name %>.activate!
      <%= session_class_name %>.create(@<%= user_singular_name %>, false)
      @<%= user_singular_name %>.send_activation_confirmation!
      flash[:notice] = "Your account has successfully activated."
      redirect_to root_url
    else
      flash[:notice] = "The activation link you entered is not valid!"
      render :action => :new
    end
  end

  def reset_password
    @<%= user_singular_name %> = <%= user_class_name %>.find_using_perishable_token(params[:reset_password_code], 1.week) || (raise Exception)

    if params[:<%= user_singular_name %>]
      @<%= user_singular_name %>.active = true
      if @<%= user_singular_name %>.update_attributes(params[:<%= user_singular_name %>].merge({:active => true}))
        flash[:notice] = "Successfully reset password."
        redirect_to <%= login_name %>_url
      else
        flash[:notice] = "There was a problem resetting your password."
      end
    end
  end

private
  def prepare_<%= user_singular_name %>
    @<%= user_singular_name %> = current_<%= user_singular_name %>
  end
end

