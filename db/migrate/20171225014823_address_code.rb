class AddressCode < ActiveRecord::Migration
  def change
    #add_column :provinces, :code, :integer#, limit: 12
    #add_column :cities, :code, :integer#, limit: 12
    #add_column :cities, :province_code, :integer#, limit: 12
    #add_column :districts, :code, :integer#, limit: 12
    #add_column :districts, :city_code, :integer#, limit: 12
    add_column :website_templates, :permit_accounts, :string
  end
end
