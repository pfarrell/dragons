Sequel.migration do
  change do
    create_table(:servers) do
      primary_key :id
      String :host
      String :database
      DateTime :created_at
      DateTime :updated_at
    end
  end
end
