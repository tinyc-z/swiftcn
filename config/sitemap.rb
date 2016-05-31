# Set the host name for URL creation
SitemapGenerator::Sitemap.default_host = "http://#{Settings.HOST}"
SitemapGenerator::Sitemap.sitemaps_path = 'sitemaps/'

SitemapGenerator::Sitemap.create do

  add '/jobs', :changefreq => 'daily', :priority => 0.8
  add '/users',:changefreq => 'daily',:priority => 0.5
  add '/about',:changefreq => 'monthly',:priority => 0.5

  Topic.find_each do |topic|
    add topic_path(topic), :lastmod => topic.updated_at, :changefreq => 'daily'
  end

  User.find_each do |user|
    add user_path(user), :lastmod => user.updated_at, :changefreq => 'weekly'
  end

  Node.is_child.find_each do |node|
    add node_path(node), :lastmod => node.updated_at, :changefreq => 'daily'
  end

end
