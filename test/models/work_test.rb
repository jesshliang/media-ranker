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
  #   before do

  #   end

  #   describe "top_media" do
  #     it "populated" do
        
  #     end

  #     it "none" do

  #     end
  #   end

  #   describe "top_books" do
  #     it "populated" do
        
  #     end

  #     it "none" do

  #     end
  #   end

  #   describe "top_albums" do
  #     it "populated" do
        
  #     end

  #     it "none" do

  #     end
  #   end

  #   describe "top_movies" do
  #     it "populated" do
        
  #     end

  #     it "none" do

  #     end
  #   end
  end

end
