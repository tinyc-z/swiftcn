class PipelineLinkFilter < HTML::Pipeline::Filter
  def call
    site_host = Settings.HOST
    white_list = self.white_list
    doc.search('a').each do |link|
      url = link['href']
      if url.present?
        begin
          host = URI.parse(url).host
          if site_host != host
            link['target'] = '_blank'
            if !white_list.include?(host)
              link['rel'] = 'nofollow'
            end
          end
        rescue => e
          link['target'] = '_blank'
          link['rel'] = 'nofollow'
        end
      end
    end
    doc
  end

  def white_list
    ['www.cocoachina.com',
    'segmentfault.com',
    'stackoverflow.com',
    'www.zhihu.com',
    'weibo.com',
    'www.v2ex.com',
    'github.com',
    'www.oschina.net',
    'www.jianshu.com',
    'objccn.io',
    'objc.io',
    'swift.gg',
    'blog.csdn.net',
    'www.raywenderlich.com',
    'www.apple.com',
    'developer.apple.com',
    'devforums.apple.com',
    'iphonedevsdk.com',
    'code4app.com',
    'itunes.apple.com',
    'iphonedevwiki.net'
    ]
  end

end
