module MongoMapper
  module Plugins
    def plugins
      @plugins ||= []
    end

    def plugin(mod)
      # for whatever reason mod.const_defined?(:ClassMethods) doesn't work in ruby192rc2+rails3b4 hence this workaround
      extend mod::ClassMethods     if mod.constants.include?(:ClassMethods)
      include mod::InstanceMethods if mod.const_defined?(:InstanceMethods)
      mod.configure(self) if mod.respond_to?(:configure)
      plugins << mod
    end
  end
end