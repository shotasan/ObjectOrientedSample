require "minitest/unit"
require "minitest/autorun"
require "./chapter9.rb"

class WheelTest < MiniTest::Unit::TestCase
  def test_calculates_diameter
    wheel = Wheel.new(26, 1.5)

    # assert_in_delta(expected, actual, delta = 0.001, message = nil) -> true
    # 期待値と実際の値の差の絶対値が与えられた絶対誤差以下である場合、検査にパスしたことになります。
    assert_in_delta(29, wheel.diameter, 0.01)
  end
end

class GearTest < MiniTest::Unit::TestCase
  def test_calculates_gear_inches
    gear = Gear.new(
      chainring: 52,
      cog: 11,
      wheel: DiameterDouble.new,
    )

    assert_in_delta(47.27, gear.gear_inches, 0.01)
  end
end

class DiameterDouble
  def diameter
    10
  end
end
