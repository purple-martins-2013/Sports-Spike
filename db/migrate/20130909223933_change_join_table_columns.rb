class ChangeJoinTableColumns < ActiveRecord::Migration
  def change
    rename_column :events_search_terms, :events_id, :event_id
    rename_column :events_search_terms, :search_terms_id, :search_term_id
  end
end
