class AddServiceNameToActiveStorageBlobs < ActiveRecord::Migration[6.0]
  def up
    add_column :active_storage_blobs, :service_name, :string

    if (configured_service = ActiveStorage::Blob.service.name)
      ActiveStorage::Blob.unscoped.update_all(service_name: configured_service)
    end

    change_column :active_storage_blobs, :service_name, :string, null: false
  end

  def down
    remove_column :active_storage_blobs, :service_name
  end
end
