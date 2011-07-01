class CreateTickets < ActiveRecord::Migration
  def change
    create_table :tickets do |t|
      t.references :user
      t.references :agent
      t.string :priority
      t.string :status
      t.string :subject
      t.text :body

      t.timestamps
    end
    add_index :tickets, :user_id
    add_index :tickets, :agent_id
  end
end
