require 'test_helper'

class <%= session_class_name.pluralize %>ControllerTest < ActionController::TestCase
  def test_new
    get :new
    assert_template 'new'
  end

  def test_create_invalid
    post :create, :<%= session_singular_name %> => { :login => "foo", :password => "badpassword" }
    assert_template 'new'
    assert_nil <%= session_class_name %>.find
  end

  def test_create_valid
    post :create, :<%= session_singular_name %> => { :login => "foo", :password => "secret" }
    assert_equal flash[:notice], "<%= login_name_title %> successful!"
    assert_redirected_to root_path
    assert_equal <%= user_plural_name %>(:foo), <%= session_class_name %>.find.<%= user_singular_name %>
  end
end

