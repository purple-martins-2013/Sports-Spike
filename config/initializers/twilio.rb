twilio_account_sid = 'AC5b3495230ea1ec1cfeef1a98ace98812'
twilio_auth_token = '1d9d7bce2fd6a4f18f9841a6f6634499'

TWILIO = Twilio::REST::Client.new twilio_account_sid, twilio_auth_token