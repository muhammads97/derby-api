# == Schema Information
#
# Table name: teams
#
#  id         :bigint           not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  captain_id :bigint           not null
#
# Indexes
#
#  index_teams_on_captain_id  (captain_id)
#
# Foreign Keys
#
#  fk_rails_...  (captain_id => users.id)
#
class Team < ApplicationRecord
  has_many :players, class_name: "User", dependent: :nullify
  has_many :requests, class_name: "JoinRequest", foreign_key: "team_id"
  has_many :invitations
  belongs_to :captain, class_name: "User", foreign_key: "captain_id"
  validates_presence_of :name
  validates_uniqueness_of :name
  validate :team_captain_is_member

  private

  def team_captain_is_member
    if self.captain.team != nil && self.captain.team_id != self.id
      errors.add(:captain, "You already belong to a team")
    end
  end

end
