module Age
  module Nodes
    class Pet
      include ApacheAge::Vertex

      attribute :gender, :string
      attribute :species, :string
      attribute :pet_name, :string

      validates :gender, :species, :pet_name, presence: true
    end
  end
end
