class Parser::Fonbet::Factor::Misc
  @@last_score = {}
  def initialize(event, live_json:)
    @counter = 0
    @event = event
    @live_json = live_json
  end

  def parse
    create_score(1)
    create_score(2)
    @counter
  end

  def self.clear_cache
    @@last_score = {}
  end

  private

  def create_score(num)
    return if last_score_equal(num)
    return if misc.try(:[], "score#{num}").nil?

    Factor.create factor_key_id: num,
                  value: misc["score#{num}"],
                  event: @event
    @counter += 1
    write_last_score(num)
  end

  def write_last_score(num)
    @@last_score[cache_key(num)] = misc["score#{num}"]
  end

  def last_score_equal(num)
    @@last_score[cache_key(num)] == misc.try(:[], "score#{num}")
  end

  def cache_key(num)
    "#{@event.external_id}_#{num}"
  end

  def misc
    @misc ||= @live_json.ru['eventMiscs'].find { |misc| misc['id'] == @event.external_id.to_i }
  end
end
