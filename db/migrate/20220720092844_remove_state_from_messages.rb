class RemoveStateFromMessages < ActiveRecord::Migration[7.0]
  def change
    remove_column :messages, :state, :string
  end
end
