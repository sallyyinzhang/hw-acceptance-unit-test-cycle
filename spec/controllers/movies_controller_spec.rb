require 'rails_helper'

describe MoviesController do

    describe "#list_directors" do
        it "Find movies with the same director" do
            @movie_id="534"
            @movie=double('random movie', :director => 'Random Director')
            expect(Movie).to receive(:find).with(@movie_id).and_return(@movie)
            get :list_directors, {:id => @movie_id}
            expect(response).to render_template(:list_directors)
        end
        it "Should redirect index page" do
            @movie_id="1234"
            @movie=double('random movie').as_null_object
            expect(Movie).to receive(:find).with(@movie_id).and_return(@movie)
            get :list_directors, {:id => @movie_id}
            expect(response).to redirect_to(movies_path)
            
        end
    end
    describe "#edit" do
        it "Should give the movie object to edit" do
            @movie = double("Random movie test", :id=>"234")
            @movie_id = "234"
            expect(Movie).to receive(:find).with(@movie_id).and_return(@movie)
            get :edit, {:id=>@movie_id}
            expect(response).to render_template(:edit)
        end
    end
    describe "#destroy" do
        it "Should delete the given object from the database" do
            @movie = double("Random movie",:title=>"Random title")
            @movie_id = "123"
            expect(Movie).to receive(:find).with(@movie_id).and_return(@movie)
            expect(@movie).to receive(:destroy).and_return(nil)
            get :destroy, {:id => @movie_id}
            expect(response).to redirect_to(movies_path)
        end
    end
    describe "#new" do
        it "Should return create view page" do
            get :new
            expect(response).to render_template(:new)
            
        end
    end
    describe "#create" do
        it "Should update database" do
            @movie_id = "234"
            @movie = double("random movie", :title => "random")
            @params = {:title => "random",:rating => "R", :director => "random"}
            expect(Movie).to receive(:create!).with(@params).and_return(@movie)
            get :create, {:id => @movie_id, :movie => @params }
            expect(response).to redirect_to(movies_path)
            
        end
    end
    describe "#update" do
        it "Should update movie params" do
            @movie_id = "123"
            @movie = double("Movie",:title => "random")
            @params = {:title => "random",:rating => "R", :director => "random"}
            expect(Movie).to receive(:find).with(@movie_id).and_return(@movie)
            expect(@movie).to receive(:update_attributes!).and_return(nil)
            get :update, {:id => @movie_id, :movie => @params}
            expect(response).to redirect_to(movie_path(@movie))
        end
    end
    describe "#show" do
        it "Should show movie attributes" do
            @movie_id = "234"
            @movie = double("movie",:title => "random")
            expect(Movie).to receive(:find).with(@movie_id).and_return(@movie)
            get :show, {:id => @movie_id}
            expect(response).to render_template(:show)
        end
    end
    describe "#index" do
        it "Should render Index view" do
            @params = {}
            @all = %w(G PG PG-13 NC-17 R)
            @movies = []
            @movies << double("random")
            @movies << double("random2")
            @return_val = double("random3")
            expect(Movie).to receive(:all_ratings).and_return(@all)
            expect(Movie).to receive(:where).with(rating: Hash[@all.map {|rating| [rating, rating]}].keys).and_return(@return_val)
            expect(@return_val).to receive(:order).with(nil).and_return(@movies)
            get :index, {}
            expect(response).to render_template(:index)
        end
    end
end