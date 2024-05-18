# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ApacheAge::Vertex do
  context 'with required minimal namespacing' do
    subject { Nodes::Pet.new(species: 'dog', pet_name: 'Fido') }

    before do
      module Nodes
        class Pet
          include ApacheAge::Vertex

          attribute :species, :string
          attribute :pet_name, :string

          validates :species, :pet_name, presence: true
        end
      end
    end

    after do
      # Remove the Nodes::Pet class
      Nodes.send(:remove_const, :Pet)

      # Optionally remove the Nodes module if it's no longer needed
      Object.send(:remove_const, :Nodes) if Nodes.constants.empty?
    end

    context 'with required attributes' do
      it { expect(subject).to be_valid }
    end
  end

  context 'node definition within a module namespace' do
    subject { Flintstones::Nodes::Pet.new(species: 'dog', pet_name: 'Fido') }

    before do
      module Flintstones
        module Nodes
          class Pet
            include ApacheAge::Vertex

            attribute :species, :string
            attribute :pet_name, :string

            validates :species, :pet_name, presence: true
          end
        end
      end
    end

    after do
      # Remove the Nodes::Pet class
      Flintstones::Nodes.send(:remove_const, :Pet)

      # Optionally remove the Nodes module if it's no longer needed
      Object.send(:remove_const, :Nodes) if Nodes.constants.empty?

      # Optionally remove the Nodes module if it's no longer needed
      Object.send(:remove_const, :Flintstones) if Flintstones.constants.empty?
    end

    context 'with required attributes' do
      it { expect(subject).to be_valid }
    end
  end
end
