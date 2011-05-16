module ActivityMonitor
  def self.included(klass)
    klass.send(:cattr_accessor, :monitoring_details)
    klass.send(:extend, ClassMethods)
  end
  
  module ClassMethods
    def monitor_activity(attrs = {})
      send(:after_create, :store_activity)
      if respond_to?(:handle_asynchronously)
        send(:handle_asynchronously, :store_activity)
      end
      self.monitoring_details = attrs
    end
  end
  
  def store_activity    
    params = {:object_type => self.class.to_s, :object_name => to_s, :verb => self.monitoring_details[:verb], :actor_id => dreamer.id, :actor_name => dreamer.display_name}
    params[:object_id], params[:object_title] = self.monitoring_details[:object_details].call(self)

    notified = []
    
    self.monitoring_details[:parties].each do |proxy, reason|
      send(proxy).each do |user|
        unless notified.include?(user.id)
          Activity.create(params.merge(:for_user_id => user.id, :reason => reason))
          notified << user.id
        end
      end
    end
  end
end