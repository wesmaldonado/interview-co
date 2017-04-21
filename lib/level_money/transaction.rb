module LevelMoney
end
def LevelMoney::to_usd(centocents)
  signifier = (centocents< 0) ? '-' : ''
  sprintf(signifier + '$%.2f', (centocents/ 10000.0).to_f.abs)
end

class LevelMoney::MonthlyReport
  # Expects LevelMoney::Transactions
  def initialize(transactions)
    @ts = transactions
    @transaction_filters = []
  end
  def transactions
   @ts.transactions
  end
  # Filter transactions by criteria such as the merchant field.
  def add_transaction_filter(filter)
    @transaction_filters << filter
  end
  def filter!
    filtered = []
    @transaction_filters.select{ |f| f[:scope] == :collection}.each do |f|
        next unless f[:name] == :credit_card_payments
        # "credit card payments are" opposite amounts (e.g. 5000000 centocents and -5000000 centocents) within 24 hours of each other
        # credit and debit pairs with equal abs amount
        # Ignore leap year and timezone issues in input by forcing to singular local timezone via to_time
        # TODO
    end
    @transaction_filters.select{ |f| f[:scope] == :transaction}.each do |f|
      @ts.filter!(f)
    end
  end
  def to_report_data
    g = Hash.new {|h,k| h[k] = [] } 
    # { "2017-04": {"spent": "$100.00", "income": "$0.00"}}
    @ts.each do |t|
      g[t.transaction_date.strftime('%Y-%m')] << t
    end
    r = {}
    spent = 0
    income = 0
    total_spent = 0
    total_income = 0
    g.keys.each do |k|
      g[k].each do |t|
        if t.debit?
          spent -= t.amount
          total_spent -= t.amount
        else
          income += t.amount
          total_income += t.amount
        end
      end
      r[k] = {"spent" => LevelMoney.to_usd(spent), "income" => LevelMoney.to_usd(income)}
    end
    # Create "average" month
    total_monthly_summaries = g.keys.size
    avg_spent  = (total_monthly_summaries > 0) ? (total_spent / total_monthly_summaries) : total_spent
    avg_income = (total_monthly_summaries > 0) ? (total_spent / total_monthly_summaries) : total_income
    r["average"] = {"spent" => LevelMoney.to_usd(avg_spent), "income" => LevelMoney.to_usd(avg_income)}
    r
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
  def merchant
    @params['merchant']
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
    @transactions = LevelMoney::Transactions.new(transactions.map{ |t| LevelMoney::Transaction.new(t) })
  end
  def initialize(list = [])
    @transactions = list
  end
  def transactions
    @transactions.dup 
  end
  def <<(i)
    @transactions << i
  end
  # filters are :field => :merchant, :matcher => 'value'
  def filter!(filter)
    # {:scope => :transaction, :merchant => { :matcher => 'ATM WITHDRAWAL' }}
    # {:scope => :collection, :name => :credit_card_payments }
    @transactions.reject! do  |t|
      t.send(filter[:field]).downcase == filter[:matcher].downcase
    end
  end
  def size
    @transactions.size
  end
  def last
    @transactions.last
  end
  def each(&block)
    @transactions.each(&block)
  end
end
