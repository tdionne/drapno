class TweetingObserver < ActiveRecord::Observer
  observe :dream
  
  def after_create(dream)
    update_twitter(dream) if dream.tweet_dream
  end
  
  protected
    def update_twitter(dream)
      url = build_short_url(dream)
      message = build_message(dream, url)
      send_to_twitter(dream, message)
    end
    
    def build_short_url(dream)
      "http://#{HOST}/d/#{dream.b58}"
    end
    
    def build_message(dream, url)
      string = '#drapno ' # 8 chars
      limit = 140 - (url.length + 8 + 2)
      string += dream.title[0..limit]
      string += " #{url}"
      string
    end
    
    def send_to_twitter(dream, message)
      oauth = Twitter::OAuth.new(OAUTH_CREDENTIALS[:twitter][:key], OAUTH_CREDENTIALS[:twitter][:secret])
      oauth.authorize_from_access(dream.dreamer.twitter.token, dream.dreamer.twitter.secret)
      client = Twitter::Base.new(oauth)
      client.update(message)
    end
end
