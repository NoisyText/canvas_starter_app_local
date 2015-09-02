admin = CreateAdminService.new.call
puts 'CREATED ADMIN USER: ' << admin.email

# Setup default accounts
if Rails.env.production?
  accounts = [{
    code: ENV["APP_SUBDOMAIN"],
    name: Rails.application.secrets.application_name,
    domain: Rails.application.secrets.application_url,
    lti_key: ENV["APP_SUBDOMAIN"],
    canvas_uri: 'https://canvas.instructure.com'
  }]
else
  accounts = [{
    code: ENV["APP_SUBDOMAIN"],
    name: Rails.application.secrets.application_name,
    domain: Rails.application.secrets.application_url,
    lti_key: ENV["APP_SUBDOMAIN"],
    lti_secret: '7c41a4bde9a07ec9490c876d5c69f99148393c24de27d8c0142f02c4764168207a9864a7ba4273420713fbd8309ac163a23b9b301f524c4ce77a01c36768a143',
    canvas_uri: 'http://localhost:3000'
  }]
end

# Setup accounts
accounts.each do |account|
  if a = Account.find_by(code: account[:code])
    a.update_attributes!(account)
  else
    Account.create!(account)
  end
end

admin.account = Account.find_by(code: ENV["APP_SUBDOMAIN"])
admin.save!
