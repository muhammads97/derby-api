# frozen_string_literal: true

# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  allow_password_change  :boolean          default(FALSE)
#  confirmation_sent_at   :datetime
#  confirmation_token     :string
#  confirmed_at           :datetime
#  email                  :string           not null
#  encrypted_password     :string           default(""), not null
#  image                  :string
#  name                   :string
#  phone_number           :string
#  phone_number_verified  :boolean          default(FALSE), not null
#  provider               :string           default("email"), not null
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string
#  role                   :integer          default("player"), not null
#  status                 :integer          default("active"), not null
#  tokens                 :json
#  uid                    :string           default(""), not null
#  unconfirmed_email      :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  team_id                :bigint
#
# Indexes
#
#  index_users_on_confirmation_token    (confirmation_token) UNIQUE
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#  index_users_on_team_id               (team_id)
#  index_users_on_uid_and_provider      (uid,provider) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (team_id => teams.id)
#
class User < ActiveRecord::Base
  extend Devise::Models

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  include DeviseTokenAuth::Concerns::User

  has_many :requests, class_name: "JoinRequest", foreign_key: "player_id"
  has_many :invitations, class_name: "Invitation", foreign_key: "player_id"
  belongs_to :team, class_name: "Team", foreign_key: "team_id", optional: true
  
  before_create :default_status
  validates_presence_of :phone_number, :name
  validates_uniqueness_of :phone_number

  enum role: %i[player referee]
  enum status: %i[active inactive]

  def captain?
    self.team.captain_id == self.id
  end

  def leave_team!
    if self.team == nil
      errors.add(:team, "you don't have a team")
      raise ActiveRecord::RecordInvalid.new(self)
      return 
    end
    if self.team.captain_id == self.id
      if self.team.players.count > 1
        self.errors.add(:captain, "You must set a captain for the team before leaving")
        raise ActiveRecord::RecordInvalid.new(self)
        return
      else
        self.team.destroy!
      end
    end
    self.team_id = nil
  end

  private

  def default_status
    if role == "referee"
      self.status = :inactive
    end
  end

end
