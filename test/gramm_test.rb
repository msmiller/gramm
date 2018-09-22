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

  test "is grammer" do
    assert(@user1.is_grammer?(@user2), "User2 should be a Grammer!")
  end

  test "send gramm" do
    @user1.send_gramm(@user2, "First Gramm", "This is the first Gramm.")
    assert(@user1.outbox_gramms.count == 1, "User1 should have 1 in the outbox")
    assert(@user2.inbox_gramms.count == 1, "User2 should have 1 in the inbox")
    assert(@user2.unread_gramms.count == 1, "User2 should have 1 unread")
  end

  test "mark unread" do
    @user1.send_gramm(@user2, "First Gramm", "This is the first Gramm.")
    @gramm = @user2.unread_gramms.first
    @gramm.mark_as_read
    assert(@user2.inbox_gramms.count == 1, "User2 should have 1 in the inbox")
    assert(@user2.unread_gramms.count == 0, "User2 should have 0 unread")
  end

  test "purge list" do
    @user1.send_gramm(@user2, "First Gramm", "This is the first Gramm.")
    @use2.send_gramm(@user1, "Second Gramm", "This is the second Gramm.")
    @gramm1 = @user2.unread_gramms.first
    assert(Gramm::purge_list.count == 0, "Purge List should have been empty")
    @gramm1.mark_as_deleted(@user1)
    assert(Gramm::purge_list.count == 0, "Purge List should have been empty")
    @gramm1.mark_as_deleted(@user2)
    assert(Gramm::purge_list.count == 1, "Purge List should have had one item")
  end

end
