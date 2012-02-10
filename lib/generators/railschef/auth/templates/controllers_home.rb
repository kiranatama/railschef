class HomeController < ApplicationController
  before_filter :require_<%= user_singular_name %>

  def index
  end
end

