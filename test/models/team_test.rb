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
require 'test_helper'

class TeamTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
