# == Schema Information
#
# Table name: supplies
#
#  id          :integer          not null, primary key
#  name        :string(255)      not null
#  price       :integer          default(0)
#  description :text
#  loanable    :boolean          default(TRUE)
#  created_at  :datetime
#  updated_at  :datetime
#  user_id     :integer
#

require 'test_helper'

class SupplyTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
