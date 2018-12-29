
module Hero
  module Gcivic
    # Your code goes here...
    #
    class Engine < ::Rails::Engine
      #isolate_namespace Gcivic

      root=config.root
      add="#{root}/lib/"
      puts "ALP #{root} adding #{add}"
      config.autoload_paths += add
      add=Dir["#{root}/app/**/"]
      config.autoload_paths += add
      # config.to_prepare do
      #   Dir.glob(Engine.root + "lib/**/**/*.rb").each do |c|
      #     puts "F #{c}"
      #     require_dependency(c)
      #   end
      # end

    end
  end
end