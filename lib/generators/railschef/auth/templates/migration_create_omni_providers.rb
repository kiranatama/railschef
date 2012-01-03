class CreateOmniProviders < ActiveRecord::Migration
  def self.up
    create_table :omni_providers do |t|
      t.integer :<%= user_singular_name %>_id
      t.string  :provider
      t.string  :uid
      t.timestamps
    end
  end

  def self.down
    drop_table :omni_providers
  end
end

