require 'byebug'

class Gear
  attr_reader :chainring, :cog, :wheel

  # 引数をハッシュにする事で引数の順番に対する依存を取り除く
  # fetchを使用したデフォルト値の指定。キーが存在しない場合だけデフォルト値が使用される。
  def initialize(args)
    @chainring = args.fetch(:chainring, 40)
    @cog = args.fetch(:cog, 18)
    @wheel = args[:wheel]
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

puts Gear.new(chainring: 52, wheel: Wheel.new(26, 1.5), cog: 11).gear_inches