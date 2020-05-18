class SetVoteDefaultToZero < ActiveRecord::Migration[6.0]
  def change
    change_column_default :works, :vote_count, 0
    change_column_default :users, :vote_count, 0
  end
end
