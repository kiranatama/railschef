class Notifier < ActionMailer::Base
  default_url_options[:host] = "myapp.domain" # APP_CONFIG[:domain]
  default :from => "My App Notifier <noreply@myapp.domain>",
          :fail_to => "My App Notifier <noreply@myapp.domain>"

  def activation_instructions(<%= user_singular_name %>)
    @account_activation_url = activate_account_url(<%= user_singular_name %>.perishable_token)

    mail(:to => <%= user_singular_name %>.email_address_with_name,
         :subject => "Activation Instructions"
    ) do |format|
      format.text
    end
  end

  def forgot_password(<%= user_singular_name %>)
    @reset_password_link = reset_password_url(<%= user_singular_name %>.perishable_token)

    mail(:to => <%= user_singular_name %>.email_address_with_name,
         :subject => "Password Reset"
    ) do |format|
      format.text
    end
  end

  def activation_confirmation(<%= user_singular_name %>)
    mail(:to => <%= user_singular_name %>.email_address_with_name,
         :subject => "Activation Complete"
    ) do |format|
      format.text
    end
  end
end

