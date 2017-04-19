require 'level_money/transaction.rb'

RSpec.describe LevelMoney::Transaction do
  Given(:transaction_data_from_api){
      {"amount"=>-1000000, "is-pending"=>false, "payee-name-only-for-testing"=>"ATM WITHDRAWAL", "aggregation-time"=>1492449140661, "account-id"=>"nonce:comfy-checking/hdhehe", "clear-date"=>1492420260000, "memo-only-for-testing"=>"Example Memo", "transaction-id"=>"1492420260000", "raw-merchant"=>"ATM WITHDRAWAL", "categorization"=>"Cash & ATM", "merchant"=>"ATM Withdrawal", "transaction-time"=>"2017-04-17T00:00:00.000Z"} 
  }
  it "can be pending" do
    expect(LevelMoney::Transaction.new(transaction_data_from_api)).not_to be_pending
  end

end
