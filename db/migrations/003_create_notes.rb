Sequel.migration do
  change do
    create_table(:notes) do
      primary_key :id
      Fixnum :path_id
      String :note
      DateTime :created_at
      DateTime :updated_at
    end
  end
end
