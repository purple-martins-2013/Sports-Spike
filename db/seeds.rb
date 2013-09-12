numbers = ['5033301096', '6079727215', '4156565920', '4153369572'] 
numbers_2 = [['7074846550', '#Saints'], ['4157105712', '#Lions'], ['9083704534', '#Lions'], ['9083704534', '#Raiders']]

search_terms = SearchTerm.all

numbers.each do |pn|
  phone_number = PhoneNumber.create(number: pn)
  search_terms.each do |term|
    phone_number.search_terms << term
  end
end

numbers_2.each do |pn|
  phone_number = PhoneNumber.where(number: pn[0]).first_or_create
  phone_number.search_terms << SearchTerm.find_by_hashtag("#{pn[1]}")
end