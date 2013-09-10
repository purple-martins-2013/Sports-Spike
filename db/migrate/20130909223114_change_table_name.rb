class ChangeTableName < ActiveRecord::Migration
  def change
    rename_table :events_search_terms_tables, :events_search_terms
  end
end
