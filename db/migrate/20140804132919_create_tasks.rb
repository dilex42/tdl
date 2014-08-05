class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.text :text
      t.references :project, index: true
      t.boolean :is_done
      t.integer :priority
      t.datetime :deadline

      t.timestamps
    end
  end
end
