Sequel.migration do
  change do
    create_table(:app_routes) do
      primary_key :id
      String :title
      String :path
      DateTime :created_at
      DateTime :updated_at
    end
  end
end
