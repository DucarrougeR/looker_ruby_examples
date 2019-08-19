require 'looker-sdk'

# get API creds from environment variables
sdk = LookerSDK::Client.new(
  :client_id => ENV['LOOKER_ID'],
  :client_secret => ENV['LOOKER_SECRET'],
  :api_endpoint => ENV['LOOKER_PATH']
)

all_integrations = looker.all_integrations(:fields => 'id, label, enabled')

all_integrations.each { | integration |
  begin
  testing = looker.test_integration(integration[:id])
    puts testing[:success] ?  "Test OK\t\t#{integration[:label]}" :  "Not Enabled\t#{integration[:label]}"
  rescue
    not_enabled = "Error with test for integration #{integration[:label]}"
    puts !integration[:enabled] ? not_enabled : "Unknown error\t#{integration[:label]}"
  end
}