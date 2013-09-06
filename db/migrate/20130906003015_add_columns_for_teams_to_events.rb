class AddColumnsForTeamsToEvents < ActiveRecord::Migration
  def change
    add_column :events, :team_one, :string
    add_column :events, :team_two, :string
  end
end
