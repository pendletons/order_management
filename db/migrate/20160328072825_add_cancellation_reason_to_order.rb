class AddCancellationReasonToOrder < ActiveRecord::Migration
  def change
    change_table :orders do |t|
      t.string :cancellation_reason
    end
  end
end
