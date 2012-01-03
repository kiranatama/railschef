class OmniProvidersController < ApplicationController
  before_filter :require_<%= user_singular_name %>, :only => [:destroy]

  def create
    omniauth = request.env['omniauth.auth']
    authentication = OmniProvider.find_by_provider_and_uid(omniauth['provider'], omniauth['uid'])

    if authentication
      # User is already registered with application
      if current_<%= user_singular_name %> && authentication.<%= user_singular_name %>_id != current_<%= user_singular_name %>.id
        flash[:error] = "Failed to add #{omniauth.provider} since it was used by another <%= account_name %>."
      end
      <%= login_name %>_and_redirect(authentication.<%= user_singular_name %>)
    elsif current_<%= user_singular_name %>
      # <%= user_class_name %> is signed in but has not already authenticated with this social network
      current_<%= user_singular_name %>.omni_providers.create!(:provider => omniauth['provider'], :uid => omniauth['uid'])
      current_<%= user_singular_name %>.apply_omniauth(omniauth)
      current_<%= user_singular_name %>.save

      flash[:notice] = "Authentication successful. <em>#{omniauth['provider'].titleize}</em> now connected with your account."
      redirect_back_or_default root_url
    else
      # <%= user_class_name %> is new to this application
      # Throw <%= user_singular_name %> to <%= login_name %> page with message to <%= login_name %> or register first
      session[:omniauth] = omniauth.except("extra")
      flash[:notice] = "Please <%= login_name %> or Register first before continue."
      redirect_to <%= login_name %>_url
    end
  end

  def destroy
    @authentication = current_<%= user_singular_name %>.omni_providers.find(params[:id])
    @authentication.destroy
    flash[:notice] = 'Successfully destroyed authentication.'
    redirect_back_or_default edit_<%= user_singular_name %>_url
  end

  private
  def <%= login_name %>_and_redirect(user)
    unless current_<%= user_singular_name %>
      <%= session_singular_name %> = <%= session_class_name %>.new(<%= user_class_name %>.find_by_single_access_token(user.single_access_token))
      <%= session_singular_name %>.save
      flash[:notice] = "<%= login_name %> successfully."
    end
    redirect_to root_path
  end

end
