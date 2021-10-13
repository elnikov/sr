# == Schema Information
#
# Table name: events
#
#  id           :bigint           not null, primary key
#  external_id  :string
#  parent_id    :bigint           default(1), not null
#  bookmaker_id :bigint           not null
#  league_id    :bigint           not null
#  sport_id     :bigint           not null
#  level        :integer          default(1), not null
#  team1_id     :bigint           not null
#  team2_id     :bigint           not null
#  slug         :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
class Event < ApplicationRecord
  belongs_to :bookmaker
  belongs_to :sport
  belongs_to :league
  belongs_to :team1, foreign_key: 'team1_id', class_name: 'Team', touch: true
  belongs_to :team2, foreign_key: 'team2_id', class_name: 'Team', touch: true

  validates :slug, presence: true, uniqueness: true
  validates :level, presence: true

  def parent
    Event.find(parent_id)
  end
end