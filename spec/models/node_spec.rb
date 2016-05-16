require 'rails_helper'

RSpec.describe Node, type: :model do

  let(:node) { FactoryGirl.create(:node) }

  it 'should fail saving without name' do
    node = Node.new
    expect(node.save).to eq false
  end

  it 'should fail saving with not uniq name' do
    node2 = Node.new(name:node.name)
    expect(node2.save).to eq false
  end

  it "create node sulg" do
    expect(node.sulg).to eq('ce-shi')
  end

end
