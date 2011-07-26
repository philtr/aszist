class CreateTicketComments < ActiveRecord::Migration
  def change
    create_table :ticket_comments do |t|
      t.references :ticket
      t.references :user
      t.text :body

      t.timestamps
    end
    add_index :ticket_comments, :ticket_id
    add_index :ticket_comments, :user_id
  end
end
