class CreateGames < ActiveRecord::Migration[6.1]
  def change
    create_table :games do |t|
      t.integer :turn, default: 0
      t.integer :status, default: 0
      t.string :board, default: '.........'

      t.timestamps
    end
  end
end
