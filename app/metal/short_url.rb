# Allow the metal piece to run in isolation
require(File.dirname(__FILE__) + "/../../config/environment") unless defined?(Rails)

class ShortUrl
  def self.call(env)
    if env["PATH_INFO"] =~ /^\/d\/([A-Za-z0-9]+)/
      id = Base58.decode($1).to_s
      [301, {"Content-Type" => "text/html", "Location" => '/dreams/' + id}, [""]]
    else
      [404, {"Content-Type" => "text/html"}, ["Not Found"]]
    end
  end
end
