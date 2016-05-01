# -*- encoding : utf-8 -*-
class CreateTips < ActiveRecord::Migration
  def change
    create_table :tips do |t|
      
      t.string :body

      t.timestamps null: false
    end
  end
end
