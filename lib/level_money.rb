require 'thor'
require 'json'
require_relative 'level_money_api/client'
require_relative 'level_money/transaction'

class CLI < Thor
  include Thor::Actions
  class_option :level_api_token, :required => true, :banner => "ENV['LEVEL_API_TOKEN']", :default => 'AppTokenForInterview'
  class_option :level_auth_token,:rquired => true, :banner => "ENV['LEVEL_AUTH_TOKEN]", :default => ENV['LEVEL_AUTH_TOKEN']
  class_option :level_uid, :required => true, :banner => "ENV['LEVEL_UID']", :default => ENV['LEVEL_UID']

  desc "report", "Report average monthly spending for your Level Money Account Transactions"
  method_option :ignore_donuts, :type => :boolean, :default => false
  def report(*params)
    exclude_transactions_by_merchant = []
    if options[:ignore_donuts]
      donut_excludes = ["Krispy Kreme Donuts","DUNKIN #336784"]
      exclude_transactions_by_merchant+ donut_excludes
    end

    unless options[:level_api_token] && options[:level_auth_token] && options[:level_uid]
      $stderr.puts "API Credentials not found, please run: levelmoney credentials"
      exit -1
    end
    client = LevelMoney::API.new(options[:level_api_token], options[:level_auth_token], options[:level_uid])
    ts = client.get_all_transactions
    report = LevelMoney::MonthlyReport.new(LevelMoney::Transactions.from_api_client(ts['transactions']))
    report.exclude_transactions_by_merchant = exclude_transactions_by_merchant
    puts report.to_report_data.to_json
  end

  desc "credentials", "Uses `curl` command to display populated ENV variables required by this program."
  method_option :level_uid, :required => false
  def credentials(api_token = 'AppTokenForInterview')
    email = ask 'What is your account email?'
    password = ask 'What is your account password?', :echo => false
    puts ""
    #TODO: Test for presence of curl
    #TODO: Move into API Client
    r = %x(curl -s -H 'Accept: application/json' -H 'Content-Type: application/json' -X POST -d '{"email": "#{email}", "password": "#{password}", "args": {"api-token": "#{api_token}", "json-strict-mode": false, "json-verbose-response": false}, "demo-account-type": "default"}' https://2016.api.levelmoney.com/api/v2/core/login)

    j = ::JSON.parse(r)
    if j["error"] != "no-error"
      $stderr.puts "Error occured, please see https://doc.level-labs.com/doc/index.html#login for help."
      exit -1
    end
    puts '# Evaluate this in your shell.'
    puts "export LEVEL_API_TOKEN='#{api_token}'"
    puts "export LEVEL_AUTH_TOKEN='#{j["token"]}'"
    puts "export LEVEL_UID='#{j["uid"]}'"
  end
end
