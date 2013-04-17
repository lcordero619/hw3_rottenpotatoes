# Add a declarative step here for populating the DB with movies.

Given /the following movies exist/ do |movies_table|
  logger = Logger.new(STDOUT)
  
  movies_table.hashes.each do |movie|
    # each returned element will be a hash whose key is the table header.
    # you should arrange to add that movie to the database here.
    Movie.create!(movie)
  end
  #flunk "Unimplemented"
end

# Make sure that one string (regexp) occurs before or after another one
#   on the same page

Then /I should see "(.*)" before "(.*)"/ do |e1, e2|
  #  ensure that that e1 occurs before e2.
  #  page.body is the entire content of the page as a string.
  flunk "Unimplemented"
end

# Calculates the number of rows of movies on page
Then /I should see ([0-9]*) movies/ do |num_movies|
  logger = Logger.new(STDOUT)
  rows_found = all("table#movies tr").count 
  logger.info "rows_found = #{rows_found}"
  logger.info "num_movies is_a #{num_movies.class}"
  logger.info "rows_found is_a #{rows_found.class}"
  # Adjust rows found for the table header.
  if num_movies.to_i != rows_found - 1
    raise "Received #{rows_found - 1} movies when expecting #{num_movies}" 
  end
end

# Make it easier to express checking or unchecking several boxes at once
#  "When I uncheck the following ratings: PG, G, R"
#  "When I check the following ratings: G"

When /I (un)?check the following ratings: (.*)/ do |uncheck, rating_list|
  # HINT: use String#split to split up the rating_list, then
  #   iterate over the ratings and reuse the "When I check..." or
  #   "When I uncheck..." steps in lines 89-95 of web_steps.rb
  logger = Logger.new(STDOUT)
  logger.info "uncheck = #{uncheck}"
  logger.info "rating_list = #{rating_list}"
  ratings = rating_list.split(/,/).each do |selection|
    box_name = "ratings[#{selection.lstrip.rstrip}]"
    logger.info "selection = #{box_name}"
    if uncheck == 'un'
      uncheck(box_name)
    else
      check(box_name)
    end
  end
end
