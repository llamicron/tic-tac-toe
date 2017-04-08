require 'simplecov'
SimpleCov.command_name 'RSpec'
SimpleCov.start

require 'rspec'

require_relative "../lib/autoload"

# This captures standard output and hides it. So when methods print things with puts, and
# i don't want them to do that in tests, it catches it and hides it. Thanks to @cldwalker on stackoverflow.
def capture_stdout(&block)
  original_stdout = $stdout
  $stdout = fake = StringIO.new
  begin
    yield
  ensure
    $stdout = original_stdout
  end
  fake.string
end
