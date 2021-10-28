require 'rails_helper'

RSpec.describe Parser::Fonbet::Event::Entity do
  let(:live_json) do
    @multilang = Struct.new(:ru, :en)
    @ru = JSON.parse(open('spec/fixtures/json/fonbet.json').read)
    @multilang.new(@ru, @ru)
  end
  let(:event) do
    ru = {
      id: 30516658,
      sortOrder: '1a007c9-oOKm',
      level: 1,
      num: 39435,
      sportId: 71239,
      kind: 1,
      rootKind: 1,
      state: {willBeLive: true},
      team1Id: 377094,
      team2Id: 400908,
      team1: 'Цзилинь Нортист Тайгерз',
      team2: 'Нанкин Манки Кингс',
      statisticsType: 'BetRadar',
      name: '',
      namePrefix: '',
      startTime: 1634358600,
      place: 'live',
      priority: 4
    }
    { 'ru': ru, 'en': ru }.with_indifferent_access
  end
  let(:entity) { described_class.new(event, live_json: live_json) }

  before do
    Parser::Fonbet::Event::Entity.clear_cache
    Parser::Fonbet::League.clear_cache
    Parser::Fonbet::Team.clear_cache
  end

  describe 'public' do
    it 'parse' do
      entity.parse
      event_db = Event.find_by(external_id: event['ru']['id'].to_s)
      expect(event_db).to be_truthy
    end
  end
end
