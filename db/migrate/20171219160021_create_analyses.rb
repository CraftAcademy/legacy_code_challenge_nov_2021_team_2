class CreateAnalyses < ActiveRecord::Migration[5.1]
  def change
    execute 'CREATE EXTENSION IF NOT EXISTS hstore'
    create_table :analyses do |t|
      t.string :category
      t.text :resource
      t.hstore :results
      t.string :request_ip

      t.timestamps
    end
  end
end
