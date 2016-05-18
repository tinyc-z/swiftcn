# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
{'Swift'=>%W"Swift 重构 设计模式 Testing 开源项目",'开发'=>%W"iOS OSX tvOS watchOS Xcode 调试 算法 安全",'社区'=>%W"公告 反馈 社区开发 线下聚会",'分享'=>%W"创意 工具 书籍 求职 招聘 合伙人 创业 移民 其他"}.each do |k,v|
  node = Node.find_or_create_by(:name => k)
  v.each do |name|
    node.childs.find_or_create_by(name:name)
  end
end

['registered', 'editer', 'admin'].each do |role|
  Role.find_or_create_by({name: role})
end

case Rails.env
when 'development','test'
    100.times do |t|
      u = User.create!({
        name:Pinyin.t(Faker::Name.name, splitter: '')+t.to_s,
        email:Faker::Internet.email,
        avatar:Faker::Avatar.image
      })
    end

    nodes = Node.where('parent_node_id > ?',0)

    1000.times do |t|
      u = User.find(rand(99)+1)
      u.topics.create({
        title:Faker::Hipster.sentence,
        body_original:Faker::Hipster.paragraph,
        node_id:nodes[rand(nodes.count)].id
      })
    end

    5000.times do |t|
      u = User.find(rand(99)+1)
      topic = Topic.find(rand(1000-1)+1)
      topic.replies.create({
        body_original:Faker::Hipster.paragraph,
        user_id:u.id
      })
    end  

end
