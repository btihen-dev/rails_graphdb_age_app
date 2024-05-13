module AgeSchema
  module Nodes
    class Person
      include ApacheAge::Vertex

      attribute :first_name, :string
      attribute :last_name, :string
      attribute :given_name, :string
      attribute :nick_name, :string
      attribute :gender, :string

      validates :gender, :first_name, :last_name, :given_name, :nick_name,
                presence: true

      def initialize(**attributes)
        super
        self.nick_name ||= first_name
        self.given_name ||= last_name
      end
    end
  end
end
