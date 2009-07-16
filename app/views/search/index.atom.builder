atom_feed(:url => search_url, :schema_date => '2009', 'xmlns:opensearch' => "http://a9.com/-/spec/opensearch/1.1/") do |feed|
  feed.title("Drapno: Search Results for \"#{h(params[:q])}\"")
  feed.updated(@results.any? ? @results.first.created_at : Time.now.utc)
  feed.tag!('openSearch:totalResults', @results.total_entries)
  feed.tag!('opensearch:startIndex', @results.offset + 1)
  feed.tag!('opensearch:itemsPerPage', @results.per_page)
  feed.tag!('opensearch:Query', :role => 'request', :searchTerms => params[:q], :startPage => @results.current_page)
  feed.tag!('opensearch:Url', :type => "application/atom+xml", :template => "#{search_url(:format => 'atom')}?q={searchTerms}&page={startPage}")

  @results.each do |result|
    feed.entry(result, :url => url_for(result)) do |entry|
      entry.title("#{result.title}")
      entry.content(result.story, :type => 'html')
      
      # result.tags.each do |tag|
      #   entry.category :term => tag.name, :scheme => 'http://www.sustainabilityforhealth.com/tags/'
      # end
      
      entry.author do |author|
        author.name(result.dreamer.name)
        author.uri(dreamer_url(result.dreamer))
      end
    end
  end
end