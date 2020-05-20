require "test_helper"

describe User do
  let (:new_user) {
    User.new(username: 'iloveducks')
  }
  
  it "can be instantiated" do
    expect(new_user.valid?).must_equal true
  end

  it "will have the required fields" do
    new_user.save
    expect(User.first).must_respond_to :username
  end

  it "will not let you create two users with the same username" do
    invalid = User.new(username: 'tails')

    expect(invalid.valid?).must_equal false
    expect(invalid.errors.messages).must_include :username
    expect(invalid.errors.messages[:username]).must_equal ["has already been taken"]
  end

  describe "relationships" do
    before do
      Vote.all.each do |vote|
        Vote.destroy(vote.id)
      end
    end
    
    it "user can have work" do
      new_vote = Vote.create(user_id: User.find_by(username: 'wizard').id, work_id: Work.find_by(title: 'Dark Star').id)

      expect(Work.find_by(title: 'Dark Star').votes.count).must_equal 1
      expect(new_vote.work).must_be_instance_of Work
    end

    it "user can have vote" do
      new_vote = Vote.create(user_id: User.find_by(username: 'witch').id, work_id: Work.find_by(title: 'Spilt Nuts').id)

      expect(User.find_by(username: 'witch').votes.count).must_equal 1
      expect(new_vote.user).must_be_instance_of User
    end 
  end

  describe "validations" do
    it "must have a username" do
      new_user.username = nil

      expect(new_user.valid?).must_equal false
      expect(new_user.errors.messages).must_include :username
    end
  end

  describe "current user" do
    it "can find the current user" do
      signed_in = users(:tails)
      result = User.find_by(id: signed_in.id).username
      expect(User.current_user(signed_in.id)).must_equal result
    end
  end

end
