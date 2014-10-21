require 'lita'
require 'httparty'
 
module Lita
  module Handlers
    class KielysAltcoinKingdom < Handler
 
      route(/^btc/, :reply_btc, command: true, help: {
	"btc" => "Returns the current BTC/USD exchange rates."
      })
 
      def reply_btc(response)
	response.reply "Bitstamp.com: Last: $#{value('last')} - High: $#{value('high')} - Low: $#{value('low')}"
      end
 
      private
 
      def data
      	@data ||= HTTParty.get(ticker_url)
      end
 
      def value(key)
        data.has_key?(key) ? data[key] : ""
      end
      
      def ticker_url
      	"https://www.bitstamp.net/api/ticker/"
      end
 
      Lita.register_handler(KielysAltcoinKingdom)
    end
  end
end