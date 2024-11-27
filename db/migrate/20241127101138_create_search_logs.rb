class CreateSearchLogs < ActiveRecord::Migration[7.0]
  def change
    create_table :search_logs do |t|
      t.string :term
      t.integer :count

      t.timestamps
    end
  end
end
