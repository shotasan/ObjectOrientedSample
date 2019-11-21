class Bicycle
  attr_reader :size, :chain, :tire_size

  # default_tire_sizeという構造をスーパークラスで定義することで、サブクラスでのオーバーライドを可能にする
  # 全ての時点スヤがチェーンには同じ初期値を持ち、タイヤサイズには異なる初期値をもつ
  def initialize(args)
    @size = args[:size]
    @chain = args[:chain] || default_chain
    @tire_size = args[:tire_size] || default_tire_size
  end

  def default_chain
    "10-speed"
  end
end

class RoadBike < Bicycle
  attr_reader :tape_color

  def initialize(args)
    @tape_color = args[:tape_color]
    super(args)
  end

  def default_tire_size
    "23"
  end

  def spares
    { chain: "10-speed", tire_size: "23", tape_color: tape_color }
  end
end

class MountainBike < Bicycle
  attr_reader :front_shock, :rear_shock

  def initialize(args)
    @front_shock = args[:front_shock]
    @rear_shock = args[:rear_shock]
    super(args)
  end

  def default_tire_size
    "2.1"
  end

  def spares
    super.merge(rear_shock: rear_shock)
  end
end

road_bike = RoadBike.new(
  size: "M",
  tape_color: "red",
  tire_size: "40",
)

p road_bike.size
p road_bike.spares
p road_bike.tire_size
p road_bike.chain

mountain_bike = MountainBike.new(
  size: "S",
  front_shock: "Manitou",
  rear_shock: "Fox",
)

p mountain_bike.size
p mountain_bike.tire_size
p mountain_bike.chain
