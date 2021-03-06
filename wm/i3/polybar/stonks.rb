require 'net/http'
require 'uri'
require 'json'

class Stonks
  attr_reader :price

  def initialize(api_key, stock)
    @api_key = api_key
    @stock = stock
    @price = nil
  end

  def fetch
    url = "https://financialmodelingprep.com/api/v3/quote/#{@stock}?apikey=#{@api_key}"
    uri = URI.parse(url)
    response = Net::HTTP.get_response(uri)
    result = JSON.parse(response.body)

    if response.code.start_with?("2")
      @price = result[0]["price"].to_f
      @percent_change = result[0]["change"].to_f
    end
  end

  def to_s
    return unless @price

    arrow = @percent_change > 0 ? "↑" : "↓"
    puts "#{@stock}: $#{"%.1f" % @price} (#{arrow}#{"%.1f" % @percent_change}%)"
  end
end

begin
  stock = Stonks.new("63193cb2454152fc84b76ed35c391f3b", ARGV[0])
  stock.fetch
  puts stock.to_s
end
