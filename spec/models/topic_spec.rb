require 'rails_helper'

RSpec.describe Topic, type: :model do
  let(:topic) { FactoryGirl.create(:topic) }

  it 'create' do
    expect(topic.title.present?).to eq true
  end

  it 'should fail saving without node' do
    topic.node = nil
    expect(topic.save).to eq false
  end

  it 'should fail saving without title' do
    topic.title = nil
    expect(topic.save).to eq false
  end

  it 'should fail saving without body' do
    topic.body = nil
    expect(topic.save).to eq false
  end

  it 'should build excerpt' do
    expect(topic.excerpt.present?).to eq true
  end

  it 'should build body' do
    expect(topic.body.present?).to eq true
  end

end
