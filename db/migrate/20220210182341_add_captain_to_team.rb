class AddCaptainToTeam < ActiveRecord::Migration[6.0]
  def change
    add_reference :teams, :captain, null: false, foreign_key: {to_table: :users}
  end
end
