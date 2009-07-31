class CreateCommentReports < ActiveRecord::Migration
  def self.up
    create_table :comment_reports do |t|
      t.integer  "reporter_id"
      t.integer  "comment_id"
      t.text     "reason"
      t.timestamps
    end
  end

  def self.down
    drop_table :comment_reports
  end
end
