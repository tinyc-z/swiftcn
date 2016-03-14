class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
   # :registerable,:recoverable,
  devise :database_authenticatable,
          :rememberable,:registerable, :trackable, :omniauthable, omniauth_providers:[:github]

  acts_as_paranoid

end
