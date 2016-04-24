# == Schema Information
#
# Table name: nodes
#
#  id             :integer          not null, primary key
#  name           :string(190)
#  sulg           :string(190)
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
  belongs_to :parent, class_name: 'Node', foreign_key: :id,primary_key: :parent_node_id

  scope :is_parent, ->{where(parent_node_id: nil)}

  before_save :build_sulg

  private
  def build_sulg
    if self.name_changed?
      self.sulg = Pinyin.t(self.name, splitter: '-').downcase #=> "zhong-guo"  
    end
  end

end
