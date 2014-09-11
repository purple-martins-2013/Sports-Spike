numbers = ['5555555555', '5555555555', '5555555555', '5555555555'] 
numbers_2 = [['5555555555', '#Saints'], ['5555555555', '#Lions'], ['5555555555', '#Lions'], ['5555555555', '#Raiders']]

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
