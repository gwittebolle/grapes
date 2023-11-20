class RemoveCountryFromWine < ActiveRecord::Migration[7.1]
  def change
    remove_column :wines, :country, :string
  end
end
