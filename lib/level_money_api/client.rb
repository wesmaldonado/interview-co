require 'httparty'
require 'logger'

module LevelMoney; end

class LevelMoney::API
  include HTTParty
  base_uri 'https://2016.api.levelmoney.com/api/v2/core'
  #logger ::Logger.new(STDOUT), :debug, :curl

  def initialize(level_api_token, level_auth_token, uid, debug = false)
    default_json_options = { 'json-strict-mode' =>  false, 'json-verbose-response' => false}
    auth_options = {'api-token':  level_api_token, 'token': level_auth_token, 'uid': uid.to_i}
    @default_params =  default_json_options.merge(auth_options)
  end

  def get_all_transactions
    body = {'args' => @default_params}.to_json
    r = self.class.post('/get-all-transactions', 
                        {:body => body,
                         :headers => {'Content-Type' => 'application/json'}
                        })
    r
  end

end
