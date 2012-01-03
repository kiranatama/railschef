require 'rails/generators/base'

module Railschef
  module Generators
    class Base < Rails::Generators::Base #:nodoc:
      def self.source_root
        @_railschef_source_root ||= File.expand_path(File.join(File.dirname(__FILE__), 'railschef', generator_name, 'templates'))
      end

      def self.banner
        "rails generate railschef:#{generator_name} #{self.arguments.map{ |a| a.usage }.join(' ')} [options]"
      end

      private

      def add_gem(name, options = {})
        gemfile_content = File.read(destination_path("Gemfile"))
        File.open(destination_path("Gemfile"), 'a') { |f| f.write("\n") } unless gemfile_content =~ /\n\Z/
        gem name, options unless gemfile_content.include? name
      end

      def print_usage
        self.class.help(Thor::Base.shell.new)
        exit
      end

      def destination_path(path)
        File.join(destination_root, path)
      end

      def log_info(info)
        log "\n"
        log :info, info
      end
    end
  end
end

