Sequel.migration do
  change do
    create_table(:databases) do
      primary_key :id
      String :connection
      DateTime :created_at
      DateTime :updated_at
    end
  end
end
