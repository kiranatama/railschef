require 'test_helper'

class <%= user_class_name.pluralize %>ControllerTest < ActionController::TestCase
  def test_new
    get :new
    assert_template 'new'
  end

  def test_create_invalid
    <%= user_class_name %>.any_instance.stubs(:valid?).returns(false)
    post :create
    assert_equal flash[:notice], 'There was a problem creating the <%= user_singular_name %>'
    assert_template 'new'
  end

  def test_create_valid
    <%= user_class_name %>.any_instance.stubs(:valid?).returns(true)
    post :create
    assert_equal flash[:notice], "Your account has been created. Please check your e-mail for your account activation instructions!"
    assert_redirected_to <%= login_name %>_url
  end

  def test_edit_without_user
    get :edit, :id => "ignored"
    assert_redirected_to login_url
  end

  def test_edit
    @controller.stubs(:current_<%= user_singular_name %>).returns(<%= user_class_name %>.first)
    get :edit, :id => "ignored"
    assert_template 'edit'
  end

  def test_update_without_user
    put :update, :id => "ignored"
    assert_redirected_to login_url
  end

  def test_update_invalid
    @controller.stubs(:current_<%= user_singular_name %>).returns(<%= user_class_name %>.first)
    <%= user_class_name %>.any_instance.stubs(:valid?).returns(false)
    assert_equal flash[:error], "<%= user_class_name %> was failed to update."
    put :update, :id => "ignored"
    assert_template 'edit'
  end

  def test_update_valid
    @controller.stubs(:current_<%= user_singular_name %>).returns(<%= user_class_name %>.first)
    <%= user_class_name %>.any_instance.stubs(:valid?).returns(true)
    assert_equal flash[:notice], "<%= user_class_name %> was successfully updated."
    put :update, :id => "ignored"
    assert_redirected_to root_url
  end
end

