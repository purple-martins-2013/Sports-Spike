class RemoveTeamColumnsFromEvents < ActiveRecord::Migration
  def change
    remove_column :events, :team_one
    remove_column :events, :team_two
  end
end
