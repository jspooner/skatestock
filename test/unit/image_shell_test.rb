require 'test_helper'

class ImageShellTest < ActiveSupport::TestCase
  def test_should_be_valid
    assert ImageShell.new.valid?
  end
end
