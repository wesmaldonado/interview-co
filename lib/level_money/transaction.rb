module LevelMoney
end

class LevelMoney::Transaction
  def initialize(params)
    @params = params
  end
  def pending?
    @params['is-pending'] == 'true'
  end
end
