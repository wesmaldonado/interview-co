require 'level_money/transaction.rb'
require 'date'
RSpec.describe LevelMoney::MonthlyReport do

  Given(:transaction_data_from_api){
      {"amount"=>-1000000, "is-pending"=>false, "payee-name-only-for-testing"=>"ATM WITHDRAWAL", "aggregation-time"=>1492449140661, "account-id"=>"nonce:comfy-checking/hdhehe", "clear-date"=>1492420260000, "memo-only-for-testing"=>"Example Memo", "transaction-id"=>"1492420260000", "raw-merchant"=>"ATM WITHDRAWAL", "categorization"=>"Cash & ATM", "merchant"=>"ATM Withdrawal", "transaction-time"=>"2017-04-17T00:00:00.000Z"}
  }
  it "produces an empty report" do
    report = LevelMoney::MonthlyReport.new(LevelMoney::Transactions.from_api_client([]))
    expect(report.to_report_data).to eq({})
  end

  it "produces the report" do
    report = LevelMoney::MonthlyReport.new(LevelMoney::Transactions.from_api_client([transaction_data_from_api]))
    expect(report.to_report_data).to eq({ "2017-04" => {"spent": "$100.00", "income": "$0.00"}})
  end
end

RSpec.describe LevelMoney::Transactions do
  Given(:transaction_data_from_api){
      {"amount"=>-1000000, "is-pending"=>false, "payee-name-only-for-testing"=>"ATM WITHDRAWAL", "aggregation-time"=>1492449140661, "account-id"=>"nonce:comfy-checking/hdhehe", "clear-date"=>1492420260000, "memo-only-for-testing"=>"Example Memo", "transaction-id"=>"1492420260000", "raw-merchant"=>"ATM WITHDRAWAL", "categorization"=>"Cash & ATM", "merchant"=>"ATM Withdrawal", "transaction-time"=>"2017-04-17T00:00:00.000Z"}
  } 

  it "can load via json from the api" do
    ts = LevelMoney::Transactions.from_api_client([transaction_data_from_api])
    expect(ts.size).to eq(1)
  end
end

RSpec.describe LevelMoney::Transaction do
  Given(:transaction_data_from_api){
      {"amount"=>-1000000, "is-pending"=>false, "payee-name-only-for-testing"=>"ATM WITHDRAWAL", "aggregation-time"=>1492449140661, "account-id"=>"nonce:comfy-checking/hdhehe", "clear-date"=>1492420260000, "memo-only-for-testing"=>"Example Memo", "transaction-id"=>"1492420260000", "raw-merchant"=>"ATM WITHDRAWAL", "categorization"=>"Cash & ATM", "merchant"=>"ATM Withdrawal", "transaction-time"=>"2017-04-17T00:00:00.000Z"} 
  }

  Given(:transaction){LevelMoney::Transaction.new(transaction_data_from_api)}

  it "can be pending" do
    expect(transaction).not_to be_pending
  end
  it "has a transaction_id" do
    expect(transaction.transaction_id).to eq(transaction_data_from_api["transaction-id"])
  end
  it "has a transaction_date" do
    td = DateTime.parse(transaction_data_from_api['transaction-time'])
    expect(transaction.transaction_date).to eq(td)
  end
  it "has a categorization" do
    expect(transaction.categorization).to eq(transaction_data_from_api["categorization"])
  end
  it "has an amount in centocents" do
    expect(transaction.amount).to eq(-1000000)
  end
  it "knows if it is a debit" do
    expect(transaction).to be_debit
  end
  it "knows if it is a credit" do
    expect(transaction).not_to be_credit
  end
  it "can report itself as a dollar amount" do
    expect(transaction.to_usd).to eq("-$100.00")
  end
end
