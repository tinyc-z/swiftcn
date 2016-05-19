# == Schema Information
#
# Table name: topics
#
#  id                 :integer          not null, primary key
#  title              :string(191)      not null
#  body               :text(65535)
#  body_original      :text(65535)
#  excerpt            :text(65535)
#  is_excellent       :boolean          default(FALSE)
#  is_wiki            :boolean          default(FALSE)
#  is_blocked         :boolean          default(FALSE)
#  replies_count      :integer          default(0)
#  view_count         :integer          default(0)
#  favorites_count    :integer          default(0)
#  votes_count        :integer          default(0)
#  last_reply_user_id :integer
#  order              :integer          default(0)
#  node_id            :integer          not null
#  user_id            :integer          not null
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  deleted_at         :datetime
#

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
