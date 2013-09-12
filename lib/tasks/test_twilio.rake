task :test_twilio => :environment do
  TWILIO.account.sms.messages.create(
  :from => "+14155084988",
  :to => "+14156565920",
  :body => "Update from SportsSpike: WE LOVE YOU OUR VALUABLE CUSTOMERS!"
  )
end