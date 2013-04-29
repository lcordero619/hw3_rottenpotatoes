class Movie < ActiveRecord::Base
  def self.all_ratings
    %w(G PG PG-13 NC-17 R)
  end

  def self.search_by_director(name)
    #logger.info "Name = #{name}"
    if name == nil or name.length == 0
      raise ArgumentError.new("Can't search by director without specifying a director")
    end
    find_all_by_director(name)
  end
end
