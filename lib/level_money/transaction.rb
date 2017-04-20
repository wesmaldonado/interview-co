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
  def <<(i)
    @transactions << i
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
