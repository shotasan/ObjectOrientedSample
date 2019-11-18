require "byebug"

# 外部インターフェースを使用する場合
module SomeFramework
  class Gear
    attr_reader :chainring, :cog, :wheel

    def initialize(chainring, cog, wheel)
      @chainring = chainring
      @cog = cog
      @wheel = wheel
    end

    def gear_inches
      ratio * diameter
    end

    def ratio
      chainring / cog.to_f
    end

    def diameter
      wheel.diameter
    end
  end
end

# 外部のインターフェースをラップする事で、引数の順番の依存を解消する
module GearWrapper
  def self.gear(args)
    SomeFramework::Gear.new(args[:chainring], args[:cog], args[:wheel])
  end
end

class Wheel
  attr_reader :rim, :tire

  def initialize(rim, tire)
    @rim = rim
    @tire = tire
  end

  def diameter
    rim + (tire * 2)
  end
end

puts GearWrapper.gear(cog: 11, wheel: Wheel.new(25, 1.5), chainring: 52).gear_inches
