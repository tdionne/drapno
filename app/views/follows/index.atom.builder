atom_feed(:url => follows_url, :schema_date => '2009') do |feed|
  feed.title("Drapno: Updates for #{current_dreamer}")
  feed.updated(@updates.any? ? @updates.first.created_at : Time.now.utc)

  @updates.each do |update|
    feed.entry(update, :url => dream_url(:id => update.object_id)) do |entry|

      entry.title("#{update.actor_name} #{update.verb} a #{update.object_type.downcase}: #{update.object_name}")
      entry.content(render(:partial => 'update.html', :object => update), :type => 'html')
      
      entry.author do |author|
        author.name(update.actor_name)
        author.uri(dreamer_url(:id => update.actor_id))
      end

    end
  end
end