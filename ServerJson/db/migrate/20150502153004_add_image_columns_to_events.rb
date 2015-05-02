class AddImageColumnsToEvents < ActiveRecord::Migration
  def self.up
    add_attachment :events, :Image
  end

  def self.down
    remove_attachment :events, :Image
  end
end
