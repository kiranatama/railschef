class <%= session_class_name %> < Authlogic::Session::Base
  authenticate_with <%= user_class_name %>
  generalize_credentials_error_messages true

  attr_accessor :email

  def to_key
    new_record? ? nil : [ self.send(self.class.primary_key) ]
  end
end

