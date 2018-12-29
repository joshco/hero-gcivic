require 'virtus'
module Hero
  module Gcivic
    class Tool
      include ActiveModel::Model
      include Virtus.model

      attribute :ocdid
      attribute :recurse, Boolean, default: false

      attr_accessor :client

      def initialize(options = {})
        @client = Client.new

        super(options)
      end

      def divisions(query = nil)
        query ||= "country us"
        all_divisions = @client.divisions(query)
        all_divisions.select {|d| /state\:[a-z]+$/ =~ d['ocdId']}
      end

      def divisions_for_select(query = nil)
        self.divisions(query).map do |d|
          [
              "#{d['name']} #{d['ocdId']}",
              d['ocdId']
          ]
        end

      end

      def representatives_rows
        if self.ocdid.presence
          reps = @client.representatives(ocdid: self.ocdid, recursive: self.recurse)
          rows = @client.representative_rows(reps)
        else
          rows = []
        end
        rows
      end

      def headers
        @client.csv_headers

      end

      def csv(rows)
        @client.representative_csv(rows)
      end

      def filename
        [
            'representatives_',
            self.ocdid.parameterize.underscore,
            '.csv'
        ].join
      end
    end
  end
end
