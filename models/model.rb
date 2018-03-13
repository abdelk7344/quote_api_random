require 'net/http'
require 'json'
require 'ConnectSDK'
require 'flickraw'

def get_quote
    topic=""
    quotes=[]
    authors=[]
    url = 'https://favqs.com/api/qotd'
    uri = URI(url)
    response = Net::HTTP.get(uri)
    result= JSON.parse(response)
    topic= result["quote"]["tags"][0]
    quotes<< result["quote"]["body"]
    authors<< result["quote"]["author"]
    {"quote"=>quotes.first, "author"=> authors.first, "topic"=>topic}
end 


def search_image(topic)

      FlickRaw.api_key=ENV["FLICK_RAW_API_KEY"]
      FlickRaw.shared_secret=ENV["FLICK_RAW_API_SECRET"]
      result = flickr.photos.search(:text => topic, :per_page => 1, :safe_search => 1, :is_commons => true)

      biggest_url = "http://farm3.staticflickr.com/2862/10835118755_3757dab0a4_h.jpg"

      result.each do |p|
        info = flickr.photos.getInfo(:photo_id => p.id)
        sizes = flickr.photos.getSizes(:photo_id => p.id)
        photo_area = 0
        
        sizes.each do |size|
          calculate_area = size.width.to_f * size.height.to_f
          
          if calculate_area > photo_area
            photo_area = calculate_area
            biggest_url = size.source
          end
        end
    end
    biggest_url
end