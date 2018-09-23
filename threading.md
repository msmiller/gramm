

### Threading

Basic threading is supported. All replies to an initial Gramm are tagged as descendents.


```ruby
@gramm.reply_to(current_user, "This is my reply") # current_user is the sender
@gramm.thread # => List of Gramms in the thread, can be accessed from replies too
@user1.inbox_gramms.threads # => List of Gramms which are thread roots
```

If you want to be able to directly inject a reply to a thread, you can add the thread_id to the normal `send_gram` method:

```ruby
@user1.send_gramm(@user2, "RE: First Gramm", "This is my reply.", @gramm.id)
```
