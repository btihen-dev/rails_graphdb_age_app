# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ApacheAge::Edge do
  context 'with required minimal namespacing' do
    let(:fred) { Nodes::CavePerson.new(name: 'Bamm-Bamm Rubble') }
    let(:wilma) { Nodes::CavePerson.create(name: 'Pebbles Flintstone') }

    before do
      module Nodes
        class CavePerson
          include ApacheAge::Vertex
          attribute :name, :string
          validates :name, presence: true
        end
      end

      module Edges
        class MarriedTo
          include ApacheAge::Edge
          attribute :role, :string
          attribute :since_year, :integer
          validates :role, :since_year, presence: true
        end
      end
    end

    after do
      # Remove the Nodes::Person class
      Nodes.send(:remove_const, :CavePerson)
      # Remove the Nodes::Person class
      Edges.send(:remove_const, :MarriedTo)

      # Optionally remove the Nodes module if it's no longer needed
      Object.send(:remove_const, :Nodes) if Nodes.constants.empty?
      # Optionally remove the Nodes module if it's no longer needed
      Object.send(:remove_const, :Edges) if Edges.constants.empty?
    end

    context 'with incomplete attributes' do
      subject { Edges::MarriedTo.new(start_node: fred, since_year: 1963) }

      it 'is not valid' do
        expect(subject).not_to be_valid
        expect(subject.errors.messages[:role]).to include("can't be blank")
        # expect(subject.errors.messages[:end_id]).to include("can't be blank")
        expect(subject.errors.messages[:end_node]).to include("can't be blank")
      end
    end

    context '.create' do
      subject { Edges::MarriedTo.create(start_node: fred, end_node: wilma, since_year: 1963, role: 'husband') }

      let(:fred) { Nodes::CavePerson.create(name: 'Bamm-Bamm Rubble') }
      let(:wilma) { Nodes::CavePerson.create(name: 'Pebbles Flintstone') }

      it { expect(subject.age_type).to eq('edge') }
      it { expect(subject.role).to eq('husband') }
      it { expect(subject.since_year).to eq(1963) }
      it { expect(subject.id).to be_present }
      it { expect(subject).to be_persisted }

      it '#update' do
        id = subject.id
        expect(subject.role).to eq('husband')
        expect(subject.since_year).to eq(1963)

        subject.update(since_year: 1964, role: 'happy')
        expect(subject.since_year).to eq(1964)
        expect(subject.role).to eq('happy')
        expect(subject.save).to be_truthy
        expect(subject.id).to eq id

        marriage = Edges::MarriedTo.find(id)
        expect(marriage.since_year).to eq(1964)
        expect(marriage.role).to eq('happy')
        expect(marriage.id).to eq(id)
      end

      xit '#save already persisted' do
        id = subject.id
        expect(subject.id).to be_present
        expect(subject.pet_name).to eq('Fido')

        subject.update(species: 'cat', pet_name: 'Whiskers')
        expect(subject.save).to be_truthy

        cat = Nodes::Pet.find(id)
        expect(cat.id).to eq(id)
        expect(cat.species).to eq('cat')
        expect(cat.pet_name).to eq('Whiskers')
      end
    end

    context '.new' do
      subject { Edges::MarriedTo.new(start_node: fred, end_node: wilma, since_year: 1963, role: 'husband') }

      it { expect(subject).to be_valid }
      it { expect(subject.age_type).to eq('edge') }
      it { expect(subject.since_year).to eq(1963) }
      it { expect(subject.role).to eq('husband') }
      it { expect(subject.start_node).to eq(fred) }
      it { expect(subject.end_node).to eq(wilma) }
    end
  end

  xcontext 'node definition within a module namespace' do
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

    context 'with incomplete attributes' do
      subject { Flintstones::Nodes::Pet.new(species: 'dog') }

      it 'is not valid' do
        expect(subject).not_to be_valid
        expect(subject.errors.messages).to eq({ pet_name: ["can't be blank"] })
      end
    end

    context '.create' do
      subject { Flintstones::Nodes::Pet.create(species: 'dog', pet_name: 'Fido') }

      it { expect(subject.age_type).to eq('vertex') }
      it { expect(subject.species).to eq('dog') }
      it { expect(subject.pet_name).to eq('Fido') }

      it 'can be updated' do
        subject.update(species: 'cat', pet_name: 'Whiskers')
        expect(subject.species).to eq('cat')
        expect(subject.save).to be_truthy
        expect(subject.id).to be_present
        id = subject.id
        cat = Flintstones::Nodes::Pet.find(id)
        expect(cat.species).to eq('cat')
        expect(cat.pet_name).to eq('Whiskers')
        expect(cat.id).to eq(id)
      end
    end

    context '.new' do
      subject { Flintstones::Nodes::Pet.new(species: 'dog', pet_name: 'Fido') }

      it { expect(subject).to be_valid }
      it { expect(subject.age_type).to eq('vertex') }
      it { expect(subject.species).to eq('dog') }
      it { expect(subject.pet_name).to eq('Fido') }
    end
  end
end
