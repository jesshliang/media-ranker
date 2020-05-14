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

  # describe "relationships" do
  #   it "" do
    
  #   end
  # end

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
      it "chooses a single random Work if there is more than 1" do
        expect(Work.top_media).must_be_instance_of Work
      end

      it "does not select a work if there are none" do
        6.times do
          Work.destroy(Work.first.id)
        end

        expect(Work.top_media).must_be_nil
      end
    end

    describe "top of a specific media" do
      describe "> 10" do
        before do
          10.times do
            Work.create(
              category: 'book', 
              title: 'Test Book',
              creator: 'Test Author',
              publication_year: '1999',
              description: "I'm a test book i'm a test book.",
            )
          end

          10.times do
            Work.create(
              category: 'movie', 
              title: 'Test movie',
              creator: 'Test Author',
              publication_year: '1999',
              description: "I'm a test movie i'm a test movie.",
            )
          end

          10.times do
            Work.create(
              category: 'album', 
              title: 'Test album',
              creator: 'Test Author',
              publication_year: '1999',
              description: "I'm a test album i'm a test album.",
            )
          end
        end

        it "for books" do
          expect(Work.top_books.length).must_equal 10
        end

        it "for albums" do
          expect(Work.top_albums.length).must_equal 10
        end

        it "for movies" do
          expect(Work.top_movies.length).must_equal 10
        end

      end

      describe "< 10" do
        it "for books" do
          expect(Work.top_books.length).must_equal 2
        end

        it "for albums" do
          expect(Work.top_albums.length).must_equal 2
        end

        it "for movies" do
          expect(Work.top_movies.length).must_equal 2
        end
      end


      describe "no medias" do
        before do
          6.times do
            Work.destroy(Work.first.id)
          end
        end

        it "for books" do
          expect(Work.top_books.length).must_equal 0
        end

        it "for albums" do
          expect(Work.top_albums.length).must_equal 0
        end

        it "for movies" do
          expect(Work.top_movies.length).must_equal 0
        end
        
      end

    end

  end

end
