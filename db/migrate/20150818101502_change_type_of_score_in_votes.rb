class ChangeTypeOfScoreInVotes < ActiveRecord::Migration
  def change
    remove_column :votes, :score
    add_column :votes, :score, :integer, default: 0
  end
end
