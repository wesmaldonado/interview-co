require 'rspec/given'

testdir = File.dirname(__FILE__)
$LOAD_PATH.unshift testdir unless $LOAD_PATH.include?(testdir)

libdir = File.dirname(File.dirname(__FILE__)) + '/lib'
$LOAD_PATH.unshift libdir unless $LOAD_PATH.include?(libdir)

require 'level_money/level_money.rb'

RSpec.describe 'Transaction' do
  Given(:transaction){}
  it "does things" do
    expect(LevelMoney::Transaction.new('blah')).to eq(4)
  end

end
