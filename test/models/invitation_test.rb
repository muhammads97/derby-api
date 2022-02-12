# == Schema Information
#
# Table name: invitations
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
#  index_invitations_on_player_id  (player_id)
#  index_invitations_on_team_id    (team_id)
#
# Foreign Keys
#
#  fk_rails_...  (player_id => users.id)
#  fk_rails_...  (team_id => teams.id)
#
require 'test_helper'

class InvitationTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
