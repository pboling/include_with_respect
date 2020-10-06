# IncludeWithRespect

*Find out if your include/extend hooks are misbehaving!*

## Why did I make this gem?

Modules have hooks on `include` and `extend`, among others. These will run every time a module is included or extended into another module or class. If the hooks should only run once, (think shared state), then running them multiple times can cause difficult to trace bugs. This gem allows developers to trace modules that are re-included multiple times into other objects.

| Project                 |  IncludeWithRespect |
|------------------------ | ----------------------- |
| gem name                |  [include_with_respect][rubygems] |
| compatibility           |  Ruby 2.0, 2.1, 2.2, 2.3, 2.4, 2.5, 2.6, 2.7 |
| license                 |  [![License: MIT](https://img.shields.io/badge/License-MIT-green.svg)][mit] |
| download rank           |  [![Downloads Today](https://img.shields.io/gem/rd/include_with_respect.svg)][github] |
| version                 |  [![Version](https://img.shields.io/gem/v/include_with_respect.svg)][rubygems] |
| dependencies            |  [![Depfu](https://badges.depfu.com/badges/7ab03542cae3755d64038f7b3e7af53e/count.svg)](https://depfu.com/github/pboling/include_with_respect?project_id=10361) |
| continuous integration  |  [![Build Status](https://travis-ci.org/pboling/include_with_respect.svg?branch=master)](https://travis-ci.org/pboling/include_with_respect) |
| test coverage           |  [![Test Coverage](https://api.codeclimate.com/v1/badges/604a8f3a996c008cb2ae/test_coverage)](https://codeclimate.com/github/pboling/include_with_respect/test_coverage) |
| maintainability         |  [![Maintainability](https://api.codeclimate.com/v1/badges/604a8f3a996c008cb2ae/maintainability)](https://codeclimate.com/github/pboling/include_with_respect/maintainability) |
| code triage             |  [![Open Source Helpers](https://www.codetriage.com/pboling/include_with_respect/badges/users.svg)](https://www.codetriage.com/pboling/include_with_respect) |
| homepage                |  [on Github.com][homepage], [on Railsbling.com][blogpage] |
| documentation           |  [on RDoc.info][documentation] |
| Spread ~♡ⓛⓞⓥⓔ♡~      |  [🌏](https://about.me/peter.boling), [👼](https://angel.co/peter-boling), [:shipit:](http://coderwall.com/pboling), [![Tweet Peter](https://img.shields.io/twitter/follow/galtzo.svg?style=social&label=Follow)](http://twitter.com/galtzo), [🌹](https://nationalprogressiveparty.org) |

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'include_with_respect'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install include_with_respect

## Usage


### With Ruby `Class`:

```ruby
module SomeOtherModule
  def self.included(base)
    base.send(:include, SomeModule)
  end
end

class MyClass
  include IncludeWithRespect::ModuleWithRespect
  include SomeModule
  include SomeOtherModule
end
```

Because `SomeOtherModule` also includes `SomeModule` two things will happen that normally do not:
1. a warning will be printed (via `puts`)
2. the duplicate inclusion will be skipped (meaning the hooks will not run again)
  - This is a major change in the behavior of including modules, but normally hooks running multiple times is not desired, or intended, which is why this gem exists!

### With Ruby `Module`:

```ruby
module MyModule
  def self.included(base)
    base.send(:include, IncludeWithRespect::ModuleWithRespect)
    base.send(:include, SomeModule)
  end
end
```

Then if `MyModule` is included somewhere that also includes `SomeModule` two things will happen that normally do not:
1. a warning will be printed (via `puts`)
2. the duplicate inclusion will be skipped (meaning the hooks will not run again)
  - This is a major change in the behavior of including modules, but normally hooks running multiple times is not desired, or intended, which is why this gem exists!

### With Rails' `ActiveSupport::Concern`

```ruby
module MyConcern
  extend ActiveSupport::Concern
  included do
    include IncludeWithRespect::ConcernWithRespect
    include SomeOtherConcern
  end
end
```

Then if `MyConcern` is included somewhere that also includes `SomeOtherConcern` two things will happen that normally do not:
1. a warning will be printed (via `puts`)
2. the duplicate inclusion will be skipped (meaning the hooks will not run again)
  - This is a major change in the behavior of including modules, but normally hooks running multiple times is not desired, or intended, which is why this gem exists!

### Raw Usage (more intrusive code changes)

```ruby
module SomeOtherModule
  def self.included(base)
    base.send(:include, SomeModule)
  end
end

class MyClass
  include IncludeWithRespect
  include_with_respect SomeModule
  include_with_respect SomeOtherModule
end
```

Same results as the other usage examples.

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/pboling/include_with_respect.

Create an issue and tell me about it, or fix it yo'sef.

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Make sure to add tests for it. This is important so I don't break it in a future version unintentionally.
6. Create new Pull Request

## Versioning

This library aims to adhere to [Semantic Versioning 2.0.0][semver].
Violations of this scheme should be reported as bugs. Specifically,
if a minor or patch version is released that breaks backward
compatibility, a new version should be immediately released that
restores compatibility. Breaking changes to the public API will
only be introduced with new major versions.

As a result of this policy, you can (and should) specify a
dependency on this gem using the [Pessimistic Version Constraint][pvc] with two digits of precision.

For example:

    spec.add_dependency 'include_with_respect', '~> 0.0'

## Legal

* [![License: MIT](https://img.shields.io/badge/License-MIT-green.svg)][mit]
* Copyright (c) 2019 [Peter H. Boling][peterboling] of [Rails Bling][railsbling]

[semver]: http://semver.org/
[pvc]: http://docs.rubygems.org/read/chapter/16#page74
[railsbling]: http://www.railsbling.com
[peterboling]: http://www.peterboling.com
[coderwall]: http://coderwall.com/pboling
[documentation]: http://rdoc.info/github/pboling/gem_bench/frames
[homepage]: https://github.com/pboling/gem_bench
[mit]: https://opensource.org/licenses/MIT
[rubygems]: https://rubygems.org/gems/include_with_respect
[about-me]: https://about.me/peter.boling
[crowdrise]: https://www.crowdrise.com/helprefugeeswithhopefortomorrowliberia/fundraiser/peterboling
[angel-list]: https://angel.co/peter-boling
[topcoder]: https://www.topcoder.com/members/pboling/
[coderwall]: http://coderwall.com/pboling
[twitter-followers]: https://img.shields.io/twitter/follow/galtzo.svg?style=social&label=Follow
[twitter]: http://twitter.com/galtzo
[blogpage]: http://www.railsbling.com/include_with_respect
[github]: https://github.com/pboling/include_with_respect
