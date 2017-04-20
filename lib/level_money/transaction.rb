module LevelMoney
end
class LevelMoney::MonthlyReport
  # Expects LevelMoney::Transcactions
  def initialize(transactions)
    @ts = transactions
  end
  def to_report_data
    # { "2017-04": {"spent": "$100.00", "income": "$0.00"}}
    {}
  end
end
class LevelMoney::Transaction
  def initialize(params)
    @params = params
  end
  def to_usd
    signifier = (amount < 0) ? '-' : ''
    sprintf(signifier + '$%.2f', (amount / 10000.0).to_f.abs)
  end
  def pending?
    @params['is-pending'] == 'true'
  end
  def transaction_id
    @params['transaction-id']
  end
  def categorization 
    @params['categorization']
  end
  def transaction_date
    @transaction_date ||= DateTime.parse(@params['transaction-time'])
  end

  def amount
    @amount ||= @params['amount'].to_i # Note: Use the money gem if we need it.
  end

  def debit?
    0 >= amount
  end

  def credit?
    ! debit?
  end
end

class LevelMoney::Transactions
  # We expect the `transactions` from the parsed JSON 
  def self.from_api_client(transactions)
    @transactions = transactions.map{ |t| LevelMoney::Transaction.new(t) }
  end
  def initialize(list = [])
    @transactions= list
  end
  def <<(i)
    @transactions<< i
  end
  def size
    @transactions.size
  end
  def last
    @transactions.last
  end
end
