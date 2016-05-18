require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { FactoryGirl.create(:user) }

  it 'should fail saving without name' do
    user = User.new
    expect(user.save).to eq false
  end

  it 'should fail saving with not uniq name' do
    user2 = User.new(name:user.name,email:'a@a.com')
    expect(user2.save).to eq false
  end

  it "create user fail with error name 1" do
    user = User.new(name:'小',email:'a@a.com')
    expect(user.save).to eq false
  end

  it "create user fail with error name 2" do
    user = User.new(name:'123-s',email:'a@a.com')
    expect(user.save).to eq false
  end

  it "create user fail with error email" do
    user = User.new(name:'xiaotest',email:'aaaa.com')
    expect(user.save).to eq false
  end


end
