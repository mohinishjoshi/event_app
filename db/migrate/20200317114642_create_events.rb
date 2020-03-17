class CreateEvents < ActiveRecord::Migration[5.2]
  def change
    create_table :events do |t|
      t.string :name
      t.datetime :event_schedule
      t.decimal :fee

      t.timestamps
    end
  end
end
