require 'spec_helper'

RSpec.describe PipeParser do
  subject { described_class.new(data) }

  describe '#people' do
    let(:data) { File.read('spec/fixtures/people_by_pipe.txt') }

    it 'returns an array of parsed Person objects' do
      expect(subject.people).to match_array([
        have_attributes(
          class: Person,
          first_name: 'Joseph',
          last_name: nil,
          city: 'New York City',
          birthdate: Date.new(1990, 10, 24),
        ),
        have_attributes(
          class: Person,
          first_name: 'Jane',
          last_name: nil,
          city: 'Denver',
          birthdate: Date.new(1995, 1, 15),
        ),
      ])
    end

    context 'when no data is provided' do
      let(:data) { nil }

      it 'returns an empty array' do
        expect(subject.people).to eq([])
      end
    end
  end
end
