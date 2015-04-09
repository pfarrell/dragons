Sequel.migration do
  change do
    add_column :databases, :last_used, DateTime
  end
end
