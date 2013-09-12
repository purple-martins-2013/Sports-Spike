task :test_twilio => :environment do
  PhoneNumber.all.each do |pn|
    TWILIO.account.sms.messages.create(
    :from => "+14155084988",
    :to => "#{pn.number}",
    :body => "Update from SportsSpike: WE LOVE YOU OUR VALUABLE CUSTOMERS!"
    )
  end
end