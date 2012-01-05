Feature: Railschef Layout Generator
  In order to have a layout
  As a rails developer
  I want to generate a simple layout

  Scenario: Generate default layout
    Given a new Rails app
    When I run "rails g railschef:layout -f"
    Then I should see "stylesheet_link_tag "application"" in file "app/views/layouts/application.html.erb"
    And I should see the following files
      | app/helpers/layout_helper.rb          |
      | app/helpers/error_messages_helper.rb  |

  Scenario: Generate named layout
    Given a new Rails app
    When I run "rails g railschef:layout admin"
    Then I should see "stylesheet_link_tag "admin"" in file "app/views/layouts/admin.html.erb"
    And I should see the following files
      | app/helpers/layout_helper.rb          |
      | app/helpers/error_messages_helper.rb  |

