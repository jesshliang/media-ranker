require "test_helper"

describe Work do

  let (:work) {
    Work.new(
      category: 'book', 
	    title: 'Test Book',
	    creator: 'Test Author',
	    publication_year: '1999',
	    description: "I'm a test book i'm a test book.",
    )
  }

  it "can be instantiated" do
    # Assert
    expect(work.valid?).must_equal true
  end

  it "will have the required fields" do
    # Arrange
    work.save
    new_work = Work.first
    [:category, :title, :creator, :publication_year, :description].each do |field|
      # Assert
      expect(new_work).must_respond_to field
    end
  end

  describe "relationships" do
    it "work can have user" do
      new_vote = Vote.create(user_id: User.find_by(username: 'wizard').id, work_id: Work.find_by(title: 'Dark Star').id)

      expect(Work.find_by(title: 'Dark Star').users[0]).must_be_instance_of User
    end

    it "work can have vote" do
      new_vote = Vote.create(user_id: User.find_by(username: 'witch').id, work_id: Work.find_by(title: 'Spilt Nuts').id)

      expect(Work.find_by(title: 'Spilt Nuts').votes[0]).must_be_instance_of Vote
    end 
  end

  describe "validations" do
    it "must have a title" do
      work.title = nil

      # Assert
      expect(work.valid?).must_equal false
      expect(work.errors.messages).must_include :title
      expect(work.errors.messages[:title]).must_equal ["can't be blank"]
    end

    it "must have a category" do
      work.category = nil

      # Assert
      expect(work.valid?).must_equal false
      expect(work.errors.messages).must_include :category
      expect(work.errors.messages[:category]).must_equal ["can't be blank"]
    end

    it "must have a creator" do
      work.creator = nil

      # Assert
      expect(work.valid?).must_equal false
      expect(work.errors.messages).must_include :creator
      expect(work.errors.messages[:creator]).must_equal ["can't be blank"]
    end

    it "must have a publication_year" do
      work.publication_year = nil

      # Assert
      expect(work.valid?).must_equal false
      expect(work.errors.messages).must_include :publication_year
      expect(work.errors.messages[:publication_year]).must_equal ["can't be blank"]
    end

    it "must have a description" do
      work.description = nil

      # Assert
      expect(work.valid?).must_equal false
      expect(work.errors.messages).must_include :description
      expect(work.errors.messages[:description]).must_equal ["can't be blank"]
    end
  end

  describe "custom methods" do
    describe "top_media" do
      before do
        @vote1 = Vote.create(user_id: users(:wizard).id, work_id: works(:postmodern).id)
        @vote1.count_votes(works(:postmodern).id, users(:wizard).id)
        @vote2 = Vote.create(user_id: users(:wizard).id, work_id: works(:huggy_equinox).id)
        @vote2.count_votes(works(:huggy_equinox).id, users(:wizard).id)
        @vote3 = Vote.create(user_id: users(:wizard).id, work_id: works(:spilt_nuts).id)
        @vote3.count_votes(works(:spilt_nuts).id, users(:wizard).id)
        @vote4 = Vote.create(user_id: users(:witch).id, work_id: works(:spilt_nuts).id)
        @vote4.count_votes(works(:spilt_nuts).id, users(:witch).id)
      end
      
      it "chooses the highest voted Work if there is more than 1" do
        expect(Work.top_media.title).must_equal "Spilt Nuts"
      end

      it "does not select a work if there are none" do
        Vote.all.each do |vote|
          Vote.destroy(vote.id)
        end

        6.times do
          Work.destroy(Work.first.id)
        end

        expect(Work.top_media).must_be_nil
      end
    end

    # describe "top of a specific media" do
    #   describe "> 10" do
    #     before do
    #       10.times do
    #         Work.create(
    #           category: 'book', 
    #           title: 'Test Book',
    #           creator: 'Test Author',
    #           publication_year: '1999',
    #           description: "I'm a test book i'm a test book.",
    #         )
    #       end

    #       10.times do
    #         Work.create(
    #           category: 'movie', 
    #           title: 'Test movie',
    #           creator: 'Test Author',
    #           publication_year: '1999',
    #           description: "I'm a test movie i'm a test movie.",
    #         )
    #       end

    #       10.times do
    #         Work.create(
    #           category: 'album', 
    #           title: 'Test album',
    #           creator: 'Test Author',
    #           publication_year: '1999',
    #           description: "I'm a test album i'm a test album.",
    #         )
    #       end
    #     end

    #     it "for books" do
    #       expect(Work.top_books.length).must_equal 10
    #     end

    #     it "for albums" do
    #       expect(Work.top_albums.length).must_equal 10
    #     end

    #     it "for movies" do
    #       expect(Work.top_movies.length).must_equal 10
    #     end

    #   end

    #   describe "< 10" do
    #     it "for books" do
    #       expect(Work.top_books.length).must_equal 2
    #     end

    #     it "for albums" do
    #       expect(Work.top_albums.length).must_equal 2
    #     end

    #     it "for movies" do
    #       expect(Work.top_movies.length).must_equal 2
    #     end
    #   end

    #   describe "no medias" do
    #     before do
    #       6.times do
    #         Work.destroy(Work.first.id)
    #       end
    #     end

    #     it "for books" do
    #       expect(Work.top_books.length).must_equal 0
    #     end

    #     it "for albums" do
    #       expect(Work.top_albums.length).must_equal 0
    #     end

    #     it "for movies" do
    #       expect(Work.top_movies.length).must_equal 0
    #     end
        
    #   end

    #   describe "will order works by highest vote" do
    #     before do
    #       @vote1 = Vote.create(user_id: users(:wizard).id, work_id: works(:postmodern).id)
    #       @vote1.count_votes(works(:postmodern).id, users(:wizard).id)
    #       @vote2 = Vote.create(user_id: users(:wizard).id, work_id: works(:huggy_equinox).id)
    #       @vote2.count_votes(works(:huggy_equinox).id, users(:wizard).id)
    #       @vote3 = Vote.create(user_id: users(:wizard).id, work_id: works(:spilt_nuts).id)
    #       @vote3.count_votes(works(:spilt_nuts).id, users(:wizard).id)
    #       @vote4 = Vote.create(user_id: users(:witch).id, work_id: works(:spilt_nuts).id)
    #       @vote4.count_votes(works(:spilt_nuts).id, users(:witch).id)
    #     end

    #     it "will list the highest voted work at the top for all works" do
    #       expect(Work.top_media.title).must_equal 'Spilt Nuts'
    #     end

    #     it "will list the highest voted book for top books" do
    #       expect(Work.top_books[0].title).must_equal 'Huggy Equinox'
    #     end

    #     it "will list the highest voted movie for top movies" do
    #       expect(Work.top_movies[0].title).must_equal 'Postmodern'
    #     end

    #     it "will list the highest voted album for top albums" do
    #       expect(Work.top_albums[0].title).must_equal 'Spilt Nuts'
    #     end
    #   end
    # end

    describe "vote_date" do
      it "finds the correct vote date" do
        work = Work.find_by(title: 'Dark Star')
        user = User.find_by(username: 'wizard')
        vote = Vote.create(user_id: user.id, work_id: work.id)
        vote_created_date = vote.created_at.strftime("%m-%d-%Y")

        result = work.vote_date(user)
        expect(result).must_equal vote_created_date
      end
    end
  end

end
