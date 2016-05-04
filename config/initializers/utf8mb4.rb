require 'active_record/connection_adapters/abstract_mysql_adapter'
# https://metova.com/blog/dev/add-emoji-support-rails-4-mysql-5-5/ 
 
module ActiveRecord
  module ConnectionAdapters
    class AbstractMysqlAdapter
      NATIVE_DATABASE_TYPES[:string] = { :name => "varchar", :limit => 191 }
    end
  end
end
