class RenameTicketCommentsToComments < ActiveRecord::Migration
  def change
    rename_table :ticket_comments, :comments
  end
end
