module ApacheAge
  module ClassMethods
    def create(**attributes)
      new(**attributes).save
    end
  end
end
