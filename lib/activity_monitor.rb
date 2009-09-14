module ActivityMonitor
  def self.included(klass)
    klass.send(:cattr_accessor, :monitoring_details)
    klass.send(:extend, ClassMethods)
    klass.send(:include, InstanceMethods)
  end
  
  module ClassMethods
    def monitor_activity(attrs = {})
      send(:after_create, :store_activity)
      self.monitoring_details = attrs
    end
  end
  
  module InstanceMethods
    def store_activity    
      params = {:object_type => self.class.to_s, :verb => self.monitoring_details[:verb], :actor_id => dreamer.id, :actor_name => dreamer.name}
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
end