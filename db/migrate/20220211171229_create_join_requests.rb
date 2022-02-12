class CreateJoinRequests < ActiveRecord::Migration[6.0]
  def change
    create_table :join_requests do |t|
      t.references :player, null: false, foreign_key: {to_table: :users}
      t.references :team, null: false, foreign_key: true
      t.integer :status, default: 0
      t.text :message

      t.timestamps
    end
  end
end
