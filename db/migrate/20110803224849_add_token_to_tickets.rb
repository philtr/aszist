class AddTokenToTickets < ActiveRecord::Migration
  def change
    add_column :tickets, :token, :string
  end
end
