module LatestStockPrice
  @@base_url = 'https://latest-stock-price.p.rapidapi.com'
  @@headers = {
    'X-RapidAPI-Key' => Rails.application.credentials.config[:rapid_api_key],
    'X-RapidAPI-Host' => 'latest-stock-price.p.rapidapi.com'
  }

  def self.get_price(indices:, identifier: nil)
    url = "#{@@base_url}/price"
    
    params = {}
    params["Indices"] = indices
    params["Identifier"] = identifier if identifier.present?

    data = Faraday.new(url: url, params: params, headers: @@headers).get

    JSON.parse(data.body)
  end

  def self.get_all_prices(identifier: nil)
    url = "#{@@base_url}/any"

    params = {}
    params["Identifier"] = identifier if identifier.present?

    data = Faraday.new(url: url, params: params, headers: @@headers).get

    JSON.parse(data.body)
  end
end