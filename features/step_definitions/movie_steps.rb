# Add a declarative step here for populating the DB with movies.

Given /the following movies exist/ do |movies_table|
  movies_table.hashes.each do |movie|
    # each returned element will be a hash whose key is the table header.
    # you should arrange to add that movie to the database here.
    Movie.create!(movie)
  end
end

# Make sure that one string (regexp) occurs before or after another one
#   on the same page

Then /I should see "(.*)" before "(.*)"/ do |e1, e2|
  #  ensure that that e1 occurs before e2.
  #  page.body is the entire content of the page as a string.
  logger = Logger.new(STDOUT)
  page_src = page.body
  #logger.info "Contents of page:\n#{page_src}"

  # Confirm that both elements are on the page
  if !page_src.include?(e1) or !page_src.include?(e2)
    raise "One of the elements searched for '#{e1}' or '#{e2}' was not found"
  end

  if page_src.index(e1) > page_src.index(e2)
    raise "'#{e1}' does not appear before '#{e2}'"
  end
  
end

# Calculates the number of rows of movies on page
Then /I should see ([0-9]*) movies/ do |num_movies|
  rows_found = all("table#movies tr").count 
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
  ratings = rating_list.split(/,/).each do |selection|
    box_name = "ratings[#{selection.lstrip.rstrip}]"
    if uncheck == 'un'
      uncheck(box_name)
    else
      check(box_name)
    end
  end
end

Then /the ([a-zA-Z]+) of "(.*)" should be "(.*)"/ do |field, movie, director|
  field_ele = find_by_id(field)
  logger = Logger.new(STDOUT)
  logger.info "!!!!!!!!!#{field} == director#{field_ele.text}"
  if !field_ele.text.include?(director)
    raise "Directory #{director} not assigned to #{movie}"
  end

end
