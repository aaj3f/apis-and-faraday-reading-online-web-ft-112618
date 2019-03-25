class SearchesController < ApplicationController
  def search
  end

  def foursquare
    begin
      resp = Faraday.get 'https://api.foursquare.com/v2/venues/search' do |req|
        req.params['client_id'] = 'M3P1DBY31XOMKT4Q2ZNKJJFPVUF5MLSIYTED34DDBT0RRVNH'
        req.params['client_secret'] = 'OBVGWNCFYCDVWA2D1FQKARYBFU52RRK5HC2F1KD5SRONQREI'
        req.params['v'] = '20160201'
        req.params['near'] = params[:zipcode]
        req.params['query'] = 'coffee shop'
        req.options.timeout = 0
      end
      body = JSON.parse(@resp.body)

      if @resp.success?
        @venues = body["response"]["venues"]
      else
        @error = body["meta"]["errorDetail"]
      end

      rescue Faraday::ConnectionFailed
      @error = "There was a timeout. Please try again."
    end

    render 'search'
  end

end
