class ChangeGameTypeToIntegerInGameRecords < ActiveRecord::Migration[7.2]
  def up
    # 必要なら string → integer の変換前にデータ変換する
    change_column :game_records, :game_type, :integer, using: 'game_type::integer'
  end

  def down
    change_column :game_records, :game_type, :string
  end
end
