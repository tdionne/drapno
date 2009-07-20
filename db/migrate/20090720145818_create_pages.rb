class CreatePages < ActiveRecord::Migration
  def self.up
    create_table :pages do |t|
      t.string :title
      t.text :content
      t.text :content_html
      t.string :permalink, :limit => 24
      t.timestamps
    end
    
    add_index :pages, :permalink, :unique => true
    
    %W(about history behind where_we_are contact).each do |page|
      Page.create!(:title => page.humanize.titleize, :content => 'TBD', :permalink => page.gsub('_', '-'))
    end
  end

  def self.down
    remove_index :pages, :column => :permalink
    drop_table :pages
  end
end
