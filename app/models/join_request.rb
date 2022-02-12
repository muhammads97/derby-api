# == Schema Information
#
# Table name: join_requests
#
#  id         :bigint           not null, primary key
#  message    :text
#  status     :integer          default(0)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  player_id  :bigint           not null
#  team_id    :bigint           not null
#
# Indexes
#
#  index_join_requests_on_player_id  (player_id)
#  index_join_requests_on_team_id    (team_id)
#
# Foreign Keys
#
#  fk_rails_...  (player_id => users.id)
#  fk_rails_...  (team_id => teams.id)
#
class JoinRequest < ApplicationRecord
  belongs_to :player, class_name: "User", foreign_key: "player_id"
  belongs_to :team

  validate :unique_request, on: :create

  state_machine :status, initial: :pending do
    state :pending, value: 0
    state :accepted, value: 1
    state :rejected, value: 2
    state :joined, value: 3

    before_transition :accepted => :joined, do: :assign_team

    event :accept do
      transition :pending => :accepted
    end

    event :reject do
      transition :pending => :rejected
    end

    event :join do
      transition :accepted => :joined
    end
  end

  validate :not_already_in_the_team, on: :create

  private

  def not_already_in_the_team
    if self.player.team_id == self.team.id
      errors.add(:request, "You're already in this team")
    end
  end

  def assign_team
    if self.player.team_id
      self.player.errors.add(:team, "Player is already in a team")
      raise ActiveRecord::InvalidRecord.new(self.player)
    end
    self.player.update!(team_id: self.team_id)
  end

  def unique_request
    if self.player.requests.find_by_team_id(self.team_id) != nil
      errors.add(:request, "you already requested to join this team")
    end
  end
end
