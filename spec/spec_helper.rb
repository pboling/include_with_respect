require 'bundler/setup'

# Third party libraries
require 'rspec/block_is_expected'
require 'silent_stream'
require 'byebug'

# This library
require 'simplecov'
SimpleCov.start

$respect_semaphore = [] # For tracking as modules get included

require 'include_with_respect'
require 'support/shared_contexts/my_context'

$original_respect_semaphore = $respect_semaphore.dup

RSpec.configure do |config|
  # only run a specific test with :focus tag
  config.filter_run_when_matching :focus

  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = '.rspec_status'

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end

  config.include SilentStream

  config.before do
    $respect_semaphore = $original_respect_semaphore.dup
  end
  config.after do
    $respect_semaphore = []
  end
end
