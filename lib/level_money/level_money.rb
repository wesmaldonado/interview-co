module LevelMoney
end

class LevelMoney::Transaction
  def self.from_json(json)
  end
  # {"amount"=>-1000000, "is-pending"=>false, "payee-name-only-for-testing"=>"ATM WITHDRAWAL", "aggregation-time"=>1492449140661, "account-id"=>"nonce:comfy-checking/hdhehe", "clear-date"=>1492420260000, "memo-only-for-testing"=>"Example Memo", "transaction-id"=>"1492420260000", "raw-merchant"=>"ATM WITHDRAWAL", "categorization"=>"Cash & ATM", "merchant"=>"ATM Withdrawal", "transaction-time"=>"2017-04-17T00:00:00.000Z"}
  def initialize(params)
  end
end

class LevelMoney::Transactions
  def self.from_json(json)
  end
  def initialize(params)
  end
end
