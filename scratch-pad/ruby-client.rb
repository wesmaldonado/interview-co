# Requirements:
# gem "rest-client"

require 'rest-client'
require "json"

# define endpoints and URL for the API
LOGIN_ENDPOINT = "/api/v2/hackathon/login"
TRANSACTIONS_ENDPOINT = "/api/v2/hackathon/get-all-transactions"
DEFAULT_BASE_URL = "https://prod-api.level-labs.com"

# Names and getter procs for every column in the transactions response
TABLE_COLUMNS =  {merchant: ->(txn) { txn["merchant"]},
                  amount: ->(txn) { "$#{ '%.2f' % (txn["amount"] / 10000.0).abs}" },
                  type: ->(txn) { txn["amount"] < 0 ? "debit" : "credit"},
                  pending: ->(txn) { txn["is_pending"] ? "pending" : "cleared" },
                  data: ->(txn) { txn["transaction-time"] }}

# generic method to make an api call against an endpoint
def api_call(endpoint, request)
  base_url = ENV['level_base_url'] || DEFAULT_BASE_URL
  url = base_url + endpoint

  response = RestClient.post url, request.to_json, :content_type => :json, :accept => :json
  JSON.parse(response.body)
end

# login to the api, returns a uid and token
def login(email, password)
  api_call(LOGIN_ENDPOINT, {email: email, password: password, args: { api_token: ENV['level_api_token'] }})
end

# create a header row for the data
def table_header
  TABLE_COLUMNS.map{|header, _| header.to_s.rjust(20) }.join("|")
end

# for each column, format the data for this row
def transaction_row(transaction)
  TABLE_COLUMNS.map{|_, prc| prc[transaction].rjust(20)}.join("|")
end

# login to the API, then use the returned credentials to request all transactions for this user
# once fetched, the transactions are formatted and printed to stdout
def render_transactions 
  login_response = login(ENV["level_email"], ENV["level_password"])
  uid = login_response["uid"]
  token = login_response["token"]
  request = {args: {uid: uid, token: token, api_token: ENV["level_api_token"]} }
  result = api_call(TRANSACTIONS_ENDPOINT, request)
  transactions = result["transactions"]
  if transactions.nil? || transactions.count == 0
    puts "Aw crap"
    puts result
  else
    puts "fetched #{transactions.count} transactions, such as #{transactions.first}"
    puts table_header
    puts transactions.map{|t| transaction_row(t) }.join("\n")
  end
end

render_transactions