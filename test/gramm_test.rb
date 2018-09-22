require 'test_helper'

class Gramm::Test < ActiveSupport::TestCase
  test "truth" do
    assert_kind_of Module, Gramm
  end

  def setup
    print_and_flush "+"
    @user1 = User.create(name: "First User")
    @user2 = User.create(name: "Second User")
  end

  test "users created" do
    assert(User.count == 2, "Didn't find two users!")
    assert(User.first.name == "First User", "First user isn't right!")
    assert(User.last.name == "Second User", "Second user isn't right!")
  end

  test "no gramms yet" do
    assert(@user1.inbox_gramms.count == 0, "There were gramms when there shouldn't be!")
  end


end
