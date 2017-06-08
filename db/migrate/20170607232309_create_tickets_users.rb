class CreateTicketsUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :tickets_users, id: false do |t|
      t.references :ticket, foreign_key: true
      t.references :user, foreign_key: true
    end
    add_index('tickets_users', ['ticket_id', 'user_id'])
  end
end
