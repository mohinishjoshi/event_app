class CreateEvents < ActiveRecord::Migration[5.2]
  def change
    create_table :events do |t|
      t.string :name, required: true
      t.datetime :event_schedule, required: true
      t.decimal :fee, required: true

      t.timestamps
    end
  end
end
