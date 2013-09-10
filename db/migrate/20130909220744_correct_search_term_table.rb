class CorrectSearchTermTable < ActiveRecord::Migration
  def change
    rename_column :search_terms, :term, :hashtag
  end
end
