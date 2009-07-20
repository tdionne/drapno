atom_feed(:url => dreams_url, :schema_date => '2009', 'xmlns:opensearch' => "http://a9.com/-/spec/opensearch/1.1/") do |feed|
  feed.title("Drapno: New Dreams")
  feed.updated(@dreams.any? ? @dreams.first.created_at : Time.now.utc)

  @dreams.each do |dream|
    feed.entry(dream, :url => url_for(dream)) do |entry|
      entry.title("#{dream.title}")
      entry.content(dream.story, :type => 'text')
      
      dream.tags.each do |tag|
        entry.category :term => tag.name, :scheme => "http://#{HOST}/tags/"
      end
      
      entry.author do |author|
        author.name(dream.dreamer.name)
        author.uri(dreamer_url(dream.dreamer))
      end
    end
  end
end