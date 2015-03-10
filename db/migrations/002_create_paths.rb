Sequel.migration do
  change do
    create_table(:paths) do
      primary_key :id
      Fixnum :database_id
      String :path
      DateTime :created_at
      DateTime :updated_at
    end
  end
end
