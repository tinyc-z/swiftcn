namespace :php2ruby do

  desc "db"
  task :convert_db => :environment do

    return #防止误操作

    odb = 'swiftcn'

    #links
    ActiveRecord::Base.connection.select_all("select * from #{odb}.links").each do |e|
      Link.create!({
        id:e['id'],
        title:e['title'],
        link:e['link'],
        cover:e['cover'],
        created_at:e['created_at'],
        updated_at:e['updated_at'],
      })
      p "create Link #{e['id']}"
    end

    #nodes
    Node.delete_all
    ActiveRecord::Base.connection.select_all("select * from #{odb}.nodes").each do |e|
      Node.create!({
        id:e['id'],
        name:e['name'],
        slug:e['slug'],
        parent_node_id:e['parent_node'],
        topics_count:e['topic_count'],
        sort:e['sort'],
        created_at:e['created_at'],
        updated_at:e['updated_at'],
        deleted_at:e['deleted_at'],
      })
      p "create Node #{e['id']}"
    end

    #tips
    ActiveRecord::Base.connection.select_all("select * from #{odb}.tips").each do |e|
      Tip.create!({
        id:e['id'],
        body:e['body'],
        created_at:e['created_at'],
        updated_at:e['updated_at'],
      })
      p "create Tip #{e['id']}"
    end

    #user
    ActiveRecord::Base.connection.select_all("select * from #{odb}.users").each do |e|
      u = User.create!({
        id:e['id'],
        email:e['email'],
        name:e['name'],
        is_banned:e['is_banned'],
        avatar:e['image_url'],
        encrypted_password:e['password'].sub('$2y$10','$2a$10'),
        # password:'0',
        topics_count:e['topic_count'],
        replies_count:e['reply_count'],
        city:e['city'],
        company:e['company'],
        twitter_account:e['twitter_account'],
        personal_website:e['personal_website'],
        signature:e['signature'],
        introduction:e['introduction'],
        unread_notification_count:e['notification_count'],
        created_at:e['created_at'],
        updated_at:e['updated_at'],
        deleted_at:e['deleted_at'],
      })

      Authentication.create!({
        user_id:e['id'],
        uid:e['github_id'],
        provider:'github',
        uname:e['github_name'],
        provider_url:e['github_url']
      })
      p "create User #{e['id']}"
    end

    # topics
    ActiveRecord::Base.connection.select_all("select * from #{odb}.topics").each do |e|
      Topic.create!({
        id:e['id'],
        title:e['title'],
        user_id:e['user_id'],
        node_id:e['node_id'],
        body_original:e['body_original'].gsub('](http://swiftcn.io/users/','](/users/'),
        is_excellent:e['is_excellent'],
        is_wiki:e['is_wiki'],
        is_blocked:e['is_blocked'],
        replies_count:e['reply_count'].to_i,
        view_count:e['view_count'].to_i,
        favorites_count:e['favorite_count'].to_i,
        votes_count:e['vote_count'].to_i,
        last_reply_user_id:e['last_reply_user_id'],
        order:e['order'],
        deleted_at:e['deleted_at'],
        created_at:e['created_at'],
        updated_at:e['updated_at'],
      })
      p "create Topic #{e['id']}"
    end


    #replies
    ActiveRecord::Base.connection.select_all("select * from #{odb}.replies").each do |e|
      if Topic.where(id:e['topic_id']).first
        Reply.create!({
          id:e['id'],
          body_original:e['body_original'].gsub('](http://swiftcn.io/users/','](/users/'),
          user_id:e['user_id'],
          topic_id:e['topic_id'],
          is_blocked:e['is_block'],
          votes_count:e['vote_count'].to_i,
          created_at:e['created_at'],
          updated_at:e['updated_at'],
        })
      end
      p "create Reply #{e['id']}"
    end

    Topic.pluck(:id).each do |id|
      Topic.reset_counters(id,:replies)
    end

    #votes
    ActiveRecord::Base.connection.select_all("select * from #{odb}.votes").each do |e|
      Vote.create!({
        id:e['id'],
        user_id:e['user_id'],
        votable_id:e['votable_id'],
        votable_type:e['votable_type'],
        is:e['is'],
        created_at:e['created_at'],
        updated_at:e['updated_at'],
      })
      p "create Vote #{e['id']}"
    end


    # Append
    ActiveRecord::Base.connection.select_all("select * from #{odb}.appends").each do |e|
      Append.create!({
        id:e['id'],
        content:e['content'],
        topic_id:e['topic_id'],
        created_at:e['created_at'],
        updated_at:e['updated_at'],
      })
      p "create Append #{e['id']}"
    end

    #assigned_roles
    # TODO

    #attentions
    ActiveRecord::Base.connection.select_all("select * from #{odb}.attentions").each do |e|
      Attention.create!({
        id:e['id'],
        user_id:e['user_id'],
        topic_id:e['topic_id'],
        created_at:e['created_at'],
        updated_at:e['updated_at'],
      })
      p "create Attention #{e['id']}"
    end

    #favorites
    ActiveRecord::Base.connection.select_all("select * from #{odb}.favorites").each do |e|
      Favorite.create!({
        id:e['id'],
        user_id:e['user_id'],
        topic_id:e['topic_id'],
        created_at:e['created_at'],
        updated_at:e['updated_at'],
      })
      p "create Favorite #{e['id']}"
    end

    Topic.pluck(:id).each do |id|
      Topic.reset_counters(id,:favorites)
    end

    #site_statuses
    SiteStatus.destroy_all
    ActiveRecord::Base.connection.select_all("select * from #{odb}.site_statuses").each do |e|
      SiteStatus.create!({
        id:e['id'],
        day_at:e['day'],
        user_count:e['register_count'].to_i,
        topic_count:e['topic_count'].to_i,
        reply_count:e['reply_count'].to_i,
        photo_count:e['image_count'].to_i,
        created_at:e['created_at'],
        updated_at:e['updated_at'],
      })
      p "create SiteStatus #{e['id']}"
    end

    #notifications 
    Notification.delete_all
    ActiveRecord::Base.connection.select_all("select * from #{odb}.notifications").each do |e|
      Notification.create!({
        id:e['id'],
        from_user_id:e['from_user_id'],
        user_id:e['user_id'],
        topic_id:e['topic_id'],
        entity_id:e['reply_id'],
        body:e['body'],
        notify_type:e['type'],
        created_at:e['created_at'],
        updated_at:e['updated_at'],
      })
      p "create Notification #{e['id']}"
    end

    Reply.all.each do |reply|
      body_original = reply.body_original.gsub('clouddn.com/uploads/images/','clouddn.com/uploads/photos/')
      reply.body_original = body_original
      reply.save
    end

    Topic.all.each do |topic|
      body_original = topic.body_original.gsub('clouddn.com/uploads/images/','clouddn.com/uploads/photos/')
      topic.body_original = body_original
      topic.save
    end

    ActiveRecord::Base.connection.select_all("select * from #{odb}.topics").each do |e|
      topic = Topic.find_by_id(e['id'])
      if topic
        topic.update_column(:updated_at,e['updated_at'])  
      end
    end

    ActiveRecord::Base.connection.select_all("select * from #{odb}.replies").each do |e|
      reply = Reply.find_by_id(e['id'])
      if reply
        reply.update_column(:updated_at,e['updated_at'])  
      end
    end

    ActiveRecord::Base.connection.select_all("select * from #{odb}.topics").each do |e|
      user = User.find_by_id(e['id'])
      if user
        user.update_column(:unread_notification_count,e['notification_count'].to_i)  
      end
    end

    #event_logs 
    EventLog.destroy_all
    EventLog.build_histroy_events

  end

end
