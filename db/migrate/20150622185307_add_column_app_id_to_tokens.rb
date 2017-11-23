class AddColumnAppIdToTokens < ActiveRecord::Migration
  def change
    add_reference :tokens, :my_app, index: true
    add_foreign_key :tokens, :my_apps
  end
end
