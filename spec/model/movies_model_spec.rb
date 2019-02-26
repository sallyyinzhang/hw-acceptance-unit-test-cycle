require 'rails_helper'

describe Movie do
    describe "Movies with the same Director" do
        it "should find movies by the same director" do
            movie1=Movie.create! :director => 'Random1'
            movie2=Movie.create! :director => 'Random1'
            expect(movie1.movies_with_same_director).to include(movie2)
        end
        it "should not find movies by different directors" do
            movie1=Movie.create! :director => 'Random1'
            movie2=Movie.create! :director => 'Random2'
            expect(movie1.movies_with_same_director).not_to include(movie2)
        end
end
end