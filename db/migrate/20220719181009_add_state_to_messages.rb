class AddStateToMessages < ActiveRecord::Migration[7.0]
  def change
    add_column :messages, :state, :string
  end
end
