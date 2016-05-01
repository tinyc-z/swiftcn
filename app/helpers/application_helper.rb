# -*- encoding : utf-8 -*-
module ApplicationHelper
  # def glyph(icon_name_postfix, hash={})
  #   content_tag :span, nil, hash.merge(class: "glyphicon glyphicon-#{icon_name_postfix.to_s.gsub('_','-')}")
  # end

  def lang(str,hash={})
    str.lang(hash)
  end

  def current_url(encode=false)
    encode ? url_encode(request.original_url) : request.original_url
  end

  def url_encode(url)
    URI.encode(url)
  end
  
  def url_decode(url)
    URI.decode(url)
  end
  
end
