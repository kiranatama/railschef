class <%= user_class_name %> < ActiveRecord::Base

  acts_as_authentic do |config|
    config.session_class = <%= session_class_name %>
  end

  <%= "has_many :omni_providers" if options.omniauth? %>

  def active?
    active
  end

  def activate!
    self.active = true
    save
  end

  def deactivate!
    self.active = false
    save
  end

  def send_activation_instructions!
    reset_perishable_token!
    Notifier.activation_instructions(self).deliver
  end

  def send_activation_confirmation!
    reset_perishable_token!
    Notifier.activation_confirmation(self).deliver
  end

  def email_address_with_name
    "#{self.login} <#{self.email}>"
  end

  def send_forgot_password!
    deactivate!
    reset_perishable_token!
    Notifier.forgot_password(self).deliver
  end

  <%- if options.omniauth? -%>
  def apply_omniauth(omniauth)
    # Update user info fetching from social network
    # For example,

    # case omniauth['provider']
    # when 'facebook'
    #   # fetch extra user info from facebook
    # when 'twitter'
    #   # fetch extra user info from twitter
    # end
  end
  <%- end -%>
end

