# -*- encoding : utf-8 -*-
module TopicsHelper
  def url_for_share_to_weibo(topic)
    "http://service.weibo.com/share/share.php?type=3&pic=&url=#{current_url(true)}&title="+url_encode("#{topic.title} @Swift-CN")
  end
  def url_for_share_to_twitter(topic)
    "https://twitter.com/intent/tweet?url=#{current_url(true)}&via=swiftcn.io&text="+url_encode("#{topic.title}")
  end
  def url_for_share_to_facebook(topic)
    "http://www.facebook.com/sharer.php?u=#{current_url(true)}"
  end
  def url_for_share_to_google(topic)
    "https://plus.google.com/share?url=#{current_url(true)}"
  end

  def reply_floor_from_index(index)
    ([0,params[:page].to_i-1].max)*Topic.per_page+index+1
  end

  def votes_count(count)
    count if count>0
  end

  def active_class(active)
    'active' if active
  end

  def display_style(display)
    'display: none;' unless display
  end

  def filter_attr(filter_name)
    selected = (params[:filter] == filter_name)
    "href=\"?filter=#{filter_name}\" #{selected ? 'class="selected"' : ''}"
  end

end
