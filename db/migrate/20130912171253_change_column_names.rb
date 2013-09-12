class ChangeColumnNames < ActiveRecord::Migration
  def change
    rename_column :phone_numbers_search_terms, :phone_numbers_id, :phone_number_id
    rename_column :phone_numbers_search_terms, :search_terms_id, :search_term_id
  end
end
