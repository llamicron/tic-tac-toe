require 'rspec/core/rake_task'

task default: %w[spec]

# task :spec, [:tc] do |t, tc|
#   RSpec::Core::RakeTask.new(:spec)
# end

RSpec::Core::RakeTask.new do |t|
  t.pattern = "spec/*.rb"
  t.verbose = false
end
