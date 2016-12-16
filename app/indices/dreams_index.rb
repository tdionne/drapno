ThinkingSphinx::Index.define :dream, :with => :active_record do
  indexes title
  indexes story
  indexes dreamer(:name), :as => :dreamer
  indexes tags(:name), :as => :tag_names

  set_property :delta => :delayed
end