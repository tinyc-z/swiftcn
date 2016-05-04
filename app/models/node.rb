# == Schema Information
#
# Table name: nodes
#
#  id             :integer          not null, primary key
#  name           :string(191)
#  sulg           :string(191)
#  parent_node_id :integer
#  topics_count   :integer          default("0")
#  sort           :integer          default("0")
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  deleted_at     :datetime
#

class Node < ActiveRecord::Base
  acts_as_paranoid

  has_many :topics
  has_many :childs, class_name: 'Node', foreign_key: :parent_node_id
  belongs_to :parent, class_name: 'Node', foreign_key: :parent_node_id

  scope :is_parent, ->{where(parent_node_id: nil)}

  before_save :build_sulg

  private
  def build_sulg
    if name_changed?
      self.sulg = Pinyin.t(name, splitter: '-').downcase #=> "zhong-guo"  
    end
  end

end
