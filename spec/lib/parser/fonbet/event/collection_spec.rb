require 'rails_helper'

RSpec.describe Parser::Fonbet::Event::Collection do
  let(:live_json) do
    @multilang = Struct.new(:ru, :en)
    @ru = JSON.parse(open('spec/fixtures/json/fonbet.json').read)
    @multilang.new(@ru, @ru)
  end
  let(:collection) { described_class.new(live_json) }
  let!(:events) { live_json.ru['events'].select { |x| x['level'] == 1 } }

  describe 'public' do
    it 'parse' do
      collection.parse
      events.each do |event|
        event_db = Event.find_by(external_id: event['id'])
        expect(event_db.team1.name_ru).to match(event['team1'])
        expect(event_db.team2.name_ru).to match(event['team2'])
      end
      events.each do |event|
        event_db = Event.find_by(external_id: event['id'])
        expect(event_db.team1.name_en).to match(event['team1'])
        expect(event_db.team2.name_en).to match(event['team2'])
      end
    end
  end
end
