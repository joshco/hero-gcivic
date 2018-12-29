module Hero
  module Gcivic
    class Client

      CIVIC_ROOT="https://www.googleapis.com/civicinfo/v2/"

      def initialize(options={})
        @api_key=options[:api_key] || ENV['GCIVIC_API_KEY']
        @conn=Faraday.new(url: CIVIC_ROOT) do |f|
          f.response :logger
          f.response :json
          f.adapter Faraday.default_adapter
        end

      end

      def representatives(options={})

        params={
            key: @api_key
        }
        case
        when address=options[:address]
          url='representatives'
          params[:address]=address
        when ocdid=options[:ocdid]
          url="representatives/#{CGI.escape(ocdid)}"
          params[:recursive]= options[:recursive] || false
        else
          raise "Unsupported query"
        end

        reps=(@conn.get url, params).body

      end


      def representative_rows(reps)
        divisions=reps['divisions']
        offices=reps['offices']
        officials=reps['officials']
        official=nil
        rows=offices.map do |office|
          begin
          office_name=office['name']
          official_indices=office['officialIndices']
          official_indices.map do |oi|
            official=officials[oi]
            official_name=official['name']
            addr=official.dig('address',0) || {}
            [
                office_name,
                office['divisionId'],
                official_name,
                official['party'],
                official.dig('emails',0),
                official.dig('emails',1),
                official.dig('phones',0),
                official.dig('phones',1),
                official.dig('urls',0),
                official.dig('urls',1),
                addr['line1'],
                addr['line2'],
                addr['city'],
                addr['state'],
                addr['zip']

            ]
          end
          rescue StandardError => ex
            puts ex.message
            pp office, official
          end

        end.flatten(1)
        rows
      end

      def csv_headers
        [
            "Office Name",
            "OCDID",
            "Name",
            "Party",
            "Email1",
            "Email2",
            "Phone1",
            "Phone2",
            "URL1",
            "URL2",
            "Address1",
            "Address2",
            "City",
            "State",
            "Zip"
        ]
      end
      def representative_csv(rows)
        csv_string=CSV.generate do |csv|
          csv << self.csv_headers
          rows.each do |row|
            csv << row
          end
        end
        csv_string
      end

      def divisions(query=nil)
        query||='country us'

        puts "FOOggg"
        (@conn.get "divisions", {query: query, key: @api_key}).body['results']
      end

    end
  end
end