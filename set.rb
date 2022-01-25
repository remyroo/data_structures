# Determine if two movie runtimes add up to equal the exact flight length.
# User shouldn't watch the same movie twice.
def can_two_movies_fill_flight?(movie_lengths, flight_length)
  # two loops = O(n^2)
  movie_lengths.each_with_index do |movie, i|
    while i < movie_lengths.size - 1
      if movie + movie_lengths[i + 1] == flight_length
        return true
      else
        i += 1
      end
    end
  end
  false
end
p can_two_movies_fill_flight?([2, 4], 1) #=> false
p can_two_movies_fill_flight?([2, 4], 6) #=> true
p can_two_movies_fill_flight?([4, 3, 2], 5) #=> true

# More efficient version:
require 'set'
def can_two_movies_fill_flight2?(movie_lengths, flight_length)
  # one loop O(n) + a set to enable accessing movies by length in O(1) time
  # hashes and sets can save time.
  movie_lengths_seen = Set.new

  movie_lengths.any? do |first_movie_length|
    matching_second_movie_length = flight_length - first_movie_length

    if movie_lengths_seen.include?(matching_second_movie_length)
      true
    else
      movie_lengths_seen.add(first_movie_length)
      false
    end
  end
end
p can_two_movies_fill_flight2?([2, 4], 1) #=> false
p can_two_movies_fill_flight2?([2, 4], 6) #=> true
p can_two_movies_fill_flight2?([4, 3, 2], 5) #=> true
