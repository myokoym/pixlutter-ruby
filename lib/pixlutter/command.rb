require "pixlutter/window"

module Pixlutter
  class Command
    class << self
      def run(*arguments)
        new.run(arguments)
      end
    end

    def initialize
    end

    def run(arguments)
      window = Pixlutter::Window.new(arguments.shift)
      window.add_files(arguments)
      window.main
    end
  end
end
