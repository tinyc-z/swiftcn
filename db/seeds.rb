# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
{'Swift'=>%W"Swift 重构 设计模式 Testing 开源项目",'开发'=>%W"iOS OSX tvOS watchOS Xcode 调试 算法 安全",'社区'=>%W"公告 反馈 社区开发 线下聚会",'分享'=>%W"创意 工具 书籍 求职 求职 合伙人 创业 移民 其他"}.each do |k,v|
  node = Node.find_or_create_by(:name => k)
  v.each do |name|
    node.childs.find_or_create_by(name:name)
  end
end

['registered', 'banned', 'editer', 'admin'].each do |role|
  Role.find_or_create_by({name: role})
end

case Rails.env
when 'development','test'
    30.times do |t|
      u = User.create!({
        name:Faker::Name.name,
        email:Faker::Internet.email,
        avatar:Faker::Avatar.image,
      })
    end

    30.times do |t|
      u = User.find t+1
      p "build user #{t+1} data..." 
      rand(50).times{
        t = u.topics.create({
              title:Faker::Hipster.sentence,
              body_original:Faker::Hipster.paragraph,
              node_id:rand(10)
            })
        rand(200).times do |tt|
          t.replies.create({
            body:Faker::Hipster.paragraph,
            user_id:u.id
          })
        end
    }
    end

end