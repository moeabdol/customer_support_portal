class CreateTickets < ActiveRecord::Migration[5.1]
  def change
    create_table :tickets do |t|
      t.text :content, null:false
      t.string :status, null: false, default: 'unresolved'

      t.timestamps
    end
  end
end
