require "pixlutter/window"

class WindowTest < Test::Unit::TestCase
  include PixlutterTestUtils

  def setup
    image_path = File.join(fixtures_dir, "butaface.png")
    @window = Pixlutter::Window.new(image_path)
  end

  def test_new
    assert_not_nil(@window)
  end
end
