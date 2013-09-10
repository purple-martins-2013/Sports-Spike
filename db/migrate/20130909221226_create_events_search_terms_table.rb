class CreateEventsSearchTermsTable < ActiveRecord::Migration
  def change
    create_table :events_search_terms_tables do |t|
      t.references :events
      t.references :search_terms
    end
  end
end
