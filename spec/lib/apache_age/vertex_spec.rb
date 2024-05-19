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

    context 'with incomplete attributes' do
      subject { Nodes::Pet.new(species: 'dog') }

      it 'is not valid' do
        expect(subject).not_to be_valid
        expect(subject.errors.messages[:pet_name]).to include("can't be blank")
        # expect(subject.errors.messages).to eq({ pet_name: ["can't be blank"] })
      end
    end

    context '.create' do
      subject { Nodes::Pet.create(species: 'dog', pet_name: 'Fido') }

      it { expect(subject.age_type).to eq('vertex') }
      it { expect(subject.species).to eq('dog') }
      it { expect(subject.pet_name).to eq('Fido') }

      it '#update' do
        id = subject.id
        expect(subject.species).to eq('dog')
        expect(subject.pet_name).to eq('Fido')

        subject.update(species: 'cat', pet_name: 'Whiskers')
        expect(subject.species).to eq('cat')
        expect(subject.pet_name).to eq('Whiskers')
        expect(subject.save).to be_truthy
        expect(subject.id).to be_present

        cat = Nodes::Pet.find(id)
        expect(cat.species).to eq('cat')
        expect(cat.pet_name).to eq('Whiskers')
        expect(cat.id).to eq(id)
      end

      it '#save already persisted' do
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
      subject { Nodes::Pet.new(species: 'dog', pet_name: 'Fido') }

      it { expect(subject).to be_valid }
      it { expect(subject.age_type).to eq('vertex') }
      it { expect(subject.species).to eq('dog') }
      it { expect(subject.pet_name).to eq('Fido') }
    end
  end

  context 'node definition within a module namespace' do
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
