class AddSentToUserFlagToComments < ActiveRecord::Migration
  def change
    add_column :comments, :sent_to_user, :boolean, :default => false
  end
end
