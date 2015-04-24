class Query < Sequel::Model
  many_to_one :database
end
