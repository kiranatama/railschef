module Railschef
  module Generators
    class LayoutGenerator < Rails::Generators::Base
      source_root File.expand_path('../templates', __FILE__)
      argument :layout_name, :type => :string, :default => 'application', :banner => 'layout_name'

      def create_layout
        template 'layout.html.erb', "app/views/layouts/#{file_name}.html.erb"
      end

      def create_helper
        copy_file 'layout_helper.rb', "app/helpers/layout_helper.rb"
        copy_file 'error_messages_helper.rb', "app/helpers/error_messages_helper.rb"
      end

    private

      def file_name
        layout_name.underscore
      end
    end
  end
end
