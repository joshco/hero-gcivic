module Hero
  module Gcivic
    class ToolsController < GcivicController

      def run
        @tool = Hero::Gcivic::Tool.new(params['hero_gcivic_tool'])
        @rows=@tool.representatives_rows

        if params['button']=='csv'
          set_cache_buster

          filename=@tool.filename
          send_data  @tool.csv(@rows), :type => 'application/force-download', :filename => filename

        else
          render
        end

      end


      def set_cache_buster
        response.headers["Cache-Control"] = "no-cache, no-store, max-age=0, must-revalidate"
        response.headers["Pragma"] = "no-cache"
        response.headers["Expires"] = "Fri, 01 Jan 1990 00:00:00 GMT"
      end

    end
  end

end
