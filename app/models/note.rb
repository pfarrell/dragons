class Note < Sequel::Model
  many_to_one :path
end
