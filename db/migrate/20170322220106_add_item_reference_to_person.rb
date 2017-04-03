class AddItemReferenceToPerson < ActiveRecord::Migration[5.0]
  def change
    add_reference :people, :item, foreign_key: true
  end
end
