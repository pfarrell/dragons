Sequel.migration do
  change do
    create_table(:queries) do
      primary_key :id
      Fixnum :database_id
      String :query
      DateTime :created_at
      DateTime :updated_at
    end
  end
end
