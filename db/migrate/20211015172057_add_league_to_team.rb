class AddLeagueToTeam < ActiveRecord::Migration[6.1]
  def change
    add_reference :teams, :league, null: false, foreign_key: true
  end
end
