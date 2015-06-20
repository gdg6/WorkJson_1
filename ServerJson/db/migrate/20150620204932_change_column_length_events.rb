class ChangeColumnLengthEvents < ActiveRecord::Migration
  def up
    change_column :events, :description, :string, limit: 300
  end

  def down
    change_column :events, :description, :string
  end
end
