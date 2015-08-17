class AddRateToAnswers < ActiveRecord::Migration
  def change
  	add_column :answers, :rate, :integer, default: 0
  end
end
