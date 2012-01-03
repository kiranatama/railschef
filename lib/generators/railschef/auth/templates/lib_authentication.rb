module Authentication
  def self.included(controller)
    controller.send :helper_method, :current_<%= user_singular_name %>, :logged_in?, :redirect_back_or_default, :require_<%= user_singular_name %>
    <%- if options.omniauth? -%>
    controller.send :helper_method, :assign_omniauth
    <%- end -%>
  end

  def logged_in?
    current_<%= user_singular_name %>
  end

  def login_required
    unless logged_in?
      store_target_location
      redirect_to <%= login_name %>_url, :alert => "You must first <%= login_name %> or sign up before accessing this page."
    end
  end

  def current_<%= session_singular_name %>
    logger.debug "ApplicationController::current_<%= session_singular_name %>"
    return @current_<%= session_singular_name %> if defined?(@current_<%= session_singular_name %>)
    @current_<%= session_singular_name %> = <%= session_class_name %>.find
  end

  def current_<%= user_singular_name %>
    logger.debug "ApplicationController::current_<%= user_singular_name %>"
    return @current_<%= user_singular_name %> if defined?(@current_<%= user_singular_name %>)
    @current_<%= user_singular_name %> = current_<%= session_singular_name %> && current_<%= session_singular_name %>.<%= user_singular_name %>
  end

  def require_<%= user_singular_name %>
    logger.debug "ApplicationController::require_<%= user_singular_name %>"
    unless current_<%= user_singular_name %>
      store_location
      flash[:notice] = "You must be logged in to access this page"
      redirect_to <%= login_name %>_url
      return false
    end
  end

  def require_no_<%= user_singular_name %>
    logger.debug "ApplicationController::require_no_<%= user_singular_name %>"
    if current_<%= user_singular_name %>
      store_location
      flash[:notice] = "You must be logged out to access this page"
      redirect_to root_url
      return false
    end
  end

  def store_location
    session[:return_to] = request.url                       # for Rails3 (request.request_uri)
  end

  def redirect_back_or_default(default, *args)
    redirect_to(session[:return_to] || default, *args)
    session[:return_to] = nil
  end

<%- if options.omniauth? -%>
  def assign_omniauth(omniauth)
    current_<%= user_singular_name %>.omni_providers.create!(:provider => omniauth['provider'], :uid => omniauth['uid'])
    current_<%= user_singular_name %>.apply_omniauth(omniauth)
    current_<%= user_singular_name %>.save
  end
<%- end -%>
end

