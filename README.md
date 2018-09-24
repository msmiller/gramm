# Gramm

At one point or another, many projects need some way to communicate either between the system and users, users and the system, or users and users. This can be things like feedback, system notifications, user support, or object-to-object messages.

Gramm is a very basic "plumbing only" messaging gem that makes it easy to allow polymorphic senders to send messages to polymorphic recipients. There's no views or controllers - that's left for the application. There's also nothing fancy like folders or complex threading or multi-recipient send.

Features include:

- Sender and recipient can be any kind of model. So this is useful in groupware environments.
- Inbox, Outbox, and Trash supported.
<!-- - Single-level thread support (replies to a first Gramm). -->
- Global "Purge List" for Gramms which both ends of a conversation have marked as deleted.

## Usage

Simply add the concern to whatever model you want to be able to send/receive Gramms.

```ruby
class User < ActiveRecord::Base
    include Gramm::ActsAsGrammer
end
```

Using Gramm is pretty easy stuff too:

```ruby
@user1 = User.first
@user2 = User.last

@user1.send_gramm(@user2, "First Gramm", "This is the first Gramm.") # => created Gramm
@user1.outbox_gramms.count # => 1
@user2.inbox_gramms.count # => 1
@user2.unread_gramms.count # => 1
```

There's some other handy accessors to help building out controllers:

```ruby
@user.all_rcvd_gramms       # All incoming Gramms, regardless of state
@user.all_sent_gramms       # All outgoing Gramms, regardless of state

@user.trashed_inbox_gramms  # Inbox Trash
@user.trashed_outbox_gramms # Outbox Trash
```

You can alter the status of a Gramm with the following methods:

```ruby
@gramm.mark_as_read     # Mark the Gramm as read
@gramm.mark_as_unread   # Mark the Gramm as unread
@gramm.mark_as_trashed  # Toggle the Gramm's Trash status'
@gramm.mark_as_deleted  # Soft-delete the Gramm
```

Viewed status applies only to the recipient. Both Sender and Recipient have independent trash and deleted status. When a Gramm is marked as deleted by either party, it is soft-deleted. Database cleanup can be done by accessing the global Purge List of Gramms which have been marked as deleted by both parties.

To get the global Purge List of deletable messages (for database cleanup):

```ruby
Gramm::purge_list
```

Note that the sender and recipient are polymorphic. So if you had a system where Users were members of Teams, you could quickly add the ability for the Team to send a Gramm to a User:

```
@user1 = User.first
@team1 = @user.team

@team1.send_gramm(@user1, "You are now a member of Team One.", "Welcome aboard!")
```

## Installation
Add this line to your application's Gemfile:

```ruby
gem 'gramm'
```

And then execute:
```bash
$ bundle
```

Or install it yourself as:
```bash
$ gem install gramm
```

The run the generator and migration:
```bash
rails generate gramm:migration
rake db:migrate
```

## Road Map

- Basic thread support (incl. 'allow_replies')

    - _This is partly coded now, but not complete. I don't need it in any of my own projects - when I do, I'll finish it._

- Allow Markdown and Html format message bodies

    - _Database support is already in, but I want to add things like sanitization of message bodies before releasing._

## Contributing

If you'd like to help out and extend this (or add the rigging for earlier versions of Rails), feel free to create a branch and generate a pull request. Please add an issue before you start in on something so I can keep track of who's doing what.

## Compatability

This was developed on Rails 5 mainly because that's what my daily stack is. It probably works on Rails 3 and 4 as there's nothing really fancy going on, but I haven't done up the extra Gemfiles and what-not to check and see.

## Testing

Just run good ole MiniTest:

```shell
bundle
bin/test
```

## License
The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
