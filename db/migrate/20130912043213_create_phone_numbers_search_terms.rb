class CreatePhoneNumbersSearchTerms < ActiveRecord::Migration
  def change
    create_table :phone_numbers_search_terms do |t|
      t.references :phone_numbers 
      t.references :search_terms
    end
  end
end
