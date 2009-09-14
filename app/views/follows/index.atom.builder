atom_feed(:url => follows_url, :schema_date => '2009') do |feed|
  feed.title("Drapno: Updates for #{current_dreamer}")
  feed.updated(@updates.any? ? @updates.first.created_at : Time.now.utc)

  @updates.each do |update|
    feed.entry(update, :url => dream_url(update.is_a?(Dream) ? update : update.dream)) do |entry|

      if update.is_a?(Dream)
        entry.title("#{update.dreamer} dreamt: #{update.title}")
        entry.content(update.story, :type => 'text')
      elsif update.is_a?(Comment) 
        if update.dream.dreamer_id == current_dreamer.id
          entry.title("New comment on your dream: #{update.dream.title} from #{update.dreamer}")
        else
          entry.title("New comment on #{update.dream.dreamer}'s dream #{update.dream.title} from #{update.dreamer}")
        end
        entry.content(update.body, :type => 'text')
      end
      
      entry.author do |author|
        author.name(update.dreamer.name)
        author.uri(dreamer_url(update.dreamer))
      end

    end
  end
end