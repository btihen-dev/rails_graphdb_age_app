module AgeSchema
  module Edges
    class WorksAt
      include ApacheAge::Edge

      attribute :employee_role, :string

      validates :employee_role, presence: true

      validates :employee_role, presence: true
    end
  end
end
