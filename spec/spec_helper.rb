RSpec.configure do |config|
  original_stderr = $stderr
  original_stdout = $stdout
  config.before(:all) do
    # Redirect stderr and stdout
    $stderr = File.new('/dev/null', 'w')
    $stdout = File.new('/dev/null', 'w')
  end
  config.after(:all) do
    $stderr = original_stderr
    $stdout = original_stdout
  end
end