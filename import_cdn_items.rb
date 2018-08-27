require "rubygems"
require "json"
require "net/http"
require "uri"
require 'fileutils'
require 'open-uri'

def download_file(url, dest)
  open(url) do |u|
    File.open('/var/www/html/images/'+dest, 'wb') { |f| f.write(u.read) }
  end
end

uri = URI('https://rhymes.ingedata.net/office/1/cdn/36341a46-a6bc-44ec-89ed-d561945ffbf8?mindate=201-01-01&maxdate=2018-01-31&page=1)

http = Net::HTTP.new(uri.host, uri.port)
http.use_ssl = true

response = http.get(uri.request_uri)
result = JSON.parse(response.body)
result.each do |data|
  download_file(data, data.split('/').last)
end




