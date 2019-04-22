class Notifier

  def self.send_welcome_email(user)
    vars = {to:[user.email],sub:{'%name%' => [user.name]}}.to_json
    Sendcloud::Mail.send_template(template_invoke_name:'swift_welcome', subject: 'Welcome! - SwiftCN', from: 'siri@mail.swiftcn.io', fromname: 'Siri', substitution_vars: vars)
  end
  
  def self.send_admin_notifi(url)
    admins = User.where(role:Role.admin).pluck(:email,:name)
    if admins.present?
      vars = {to:admins.map{|u|u[0]},sub:{'%name%' => admins.map{|u|u[1]}, '%url%'=>admins.map{ url } }}.to_json
      Sendcloud::Mail.send_template(template_invoke_name:'admin_notification', subject: '有新贴 - SwiftCN', from: 'siri@mail.swiftcn.io', fromname: 'Siri', substitution_vars: vars)
    end
  end

  def self.send_unread_email(user)
    vars = {to:[user.email],sub:{'%name%' => [user.name]}}.to_json
    Sendcloud::Mail.send_template(template_invoke_name:'swift_unread_msg', subject: '一条未读消息 - SwiftCN', from: 'siri@mail.swiftcn.io', fromname: 'Siri', substitution_vars: vars)
  end

end