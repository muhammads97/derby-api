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
require 'test_helper'

class JoinRequestTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
