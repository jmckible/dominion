require 'dominion'
include Dominion # Not sure why it's done this way

Spec::Runner.configure do |config|
  def running(&block)
    lambda &block
  end
end
