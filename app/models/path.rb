class Path < Sequel::Model
  many_to_one :database
  one_to_many :notes
end
