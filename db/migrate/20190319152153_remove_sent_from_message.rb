class RemoveSentFromMessage < ActiveRecord::Migration[5.2]
  def change
    remove_column :messages, :sent
  end
end
