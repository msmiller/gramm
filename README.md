# Gramm

At one point or another, many projects need some way to communicate either between the system and users, users and the system, or users and users. This can be things like feedback, system notifications, user support, or object-to-object messages.

Gramm is a very basic "plumbing only" messaging gem that makes it easy to allow polymorphic senders send messages to polymorphic recipients. There's no views or controllers - that's left for the application. There's also nothing fancy like folders or complex threading, or multi-recipient send. 

Features include:

- Sender and recipient can be any kind of model. So this is useful in groupware environments.
- Inbox, Outbox, and Trash supported.
- Single-level thread support (replies to a first Gramm).
- Global "Purge List" for Gramms which bother ends of a conversation have marked as deleted.

## Usage

Simply add the concern to whatever model you want to be able to send/receive Gramms.

```ruby
class User < ActiveRecord::Base
  acts_as_grammer
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

To get the global Purge List of deletable messages (for database cleanup):

```ruby
Gramm::purge_list
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

## Contributing
Contribution directions go here.

## License
The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
