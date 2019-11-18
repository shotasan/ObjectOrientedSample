require 'byebug'

class Gear
  attr_reader :chainring, :cog, :wheel

  # 引数をハッシュにする事で引数の順番に対する依存を取り除く
  # mergeを使用したデフォルト値の設定
  # defaultsメソッドとmergeを使用する事で、引数にキーが存在しない場合にdefaultsのキーと値が設定される
  def initialize(args)
    args = defaults.merge(args)
    @chainring = args[:chainring]
    @cog = args[:cog]
    @wheel = args[:wheel]
  end

  def defaults
    {chainring: 40, cog: 18}
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