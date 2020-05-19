require "test_helper"

describe Vote do
  let (:new_vote) {
    Vote.new(user_id: User.find_by(username: 'witch').id, work_id: Work.find_by(title: 'Dark Star').id)
  }
  
  it "can be instantiated" do
    expect(new_vote.valid?).must_equal true
  end

  it "will have the required fields" do
    new_vote.save
    vote = Vote.first
    [:user_id, :work_id].each do |field|
      expect(vote).must_respond_to field
    end
  end

  describe "relationships" do
    before do
      Vote.all.each do |vote|
        Vote.destroy(vote.id)
      end
    end

    it "vote can have work" do
      new_vote.save
      Vote.create(user_id: User.find_by(username: 'wizard').id, work_id: Work.find_by(title: 'Dark Star').id)

      Work.find_by(title: 'Dark Star').votes.each do |vote|
        puts User.find_by(id:vote.user_id).username
        
      end
      expect(Work.find_by(title: 'Dark Star').votes.count).must_equal 2
      expect(new_vote.work).must_be_instance_of Work
    end

    it "vote can have many user" do
      new_vote.save
      Vote.create(user_id: User.find_by(username: 'witch').id, work_id: Work.find_by(title: 'Spilt Nuts').id)

      expect(User.find_by(username: 'witch').votes.count).must_equal 2
      expect(new_vote.user).must_be_instance_of User
    end
  end

  describe "validations" do
    it "must have a user ID" do
      new_vote.user_id = nil

      expect(new_vote.valid?).must_equal false
      expect(new_vote.errors.messages).must_include :user
    end

    it "must have a work ID" do
      new_vote.work_id = nil

      expect(new_vote.valid?).must_equal false
      expect(new_vote.errors.messages).must_include :work
    end
  end

  describe "count votes" do
    it "counts votes" do
      vote1 = Vote.create(user_id: User.find_by(username: 'witch').id, work_id: Work.find_by(title: 'Dark Star').id)
      vote1.count_votes(Work.find_by(title: 'Dark Star').id, User.find_by(username: 'witch').id)
      vote2 = Vote.create(user_id: User.find_by(username: 'witch').id, work_id: Work.find_by(title: 'Spilt Nuts').id)
      vote2.count_votes(Work.find_by(title: 'Spilt Nuts').id, User.find_by(username: 'witch').id)
      vote3 = Vote.create(user_id: User.find_by(username: 'witch').id, work_id: Work.find_by(title: 'Huggy Equinox').id)
      vote3.count_votes(Work.find_by(title: 'Huggy Equinox').id, User.find_by(username: 'witch').id)

      expect(User.find_by(username: 'witch').vote_count).must_equal 3
      expect(Work.find_by(title: 'Dark Star').vote_count).must_equal 1
    end

    it "returns 0 if no votes have been made" do
      expect(Work.first.vote_count).must_equal 0
    end
  end

end
