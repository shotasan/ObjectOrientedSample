require "byebug"

class Bicycle
  attr_reader :size, :chain, :tire_size

  def initialize(args)
    @size = args[:size]
    @chain = args[:chain] || default_chain
    @tire_size = args[:tire_size] || default_tire_size

    # サブクラス独自の属性を取得
    # サブクラスではinitializeが不要になる
    post_initialize(args)
  end

  # フックメッセージ
  def post_initialize(args)
    nil
  end

  def spares
    # サブクラスでオーバーライドされたlocal_sparesによりハッシュが返される
    { tire_size: tire_size, chain: chain }.merge(local_spares)
  end

  def local_spares
    {}
  end

  def default_chain
    "10-speed"
  end

  def default_tire_size
    raise NotImplementedError,
      "this #{self.class} cannot respond to"
  end
end

class RoadBike < Bicycle
  attr_reader :tape_color

  # Bicycleのメソッドをオーバーライド
  def post_initialize(args)
    @tape_color = args[:tape_color]
  end

  def default_tire_size
    "23"
  end

  def local_spares
    { tape_color: tape_color }
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

  def local_spares
    { front_shock: front_shock, rear_shock: rear_shock }
  end
end

class RecumbentBike < Bicycle
  attr_reader :flag

  def post_initialize(args)
    @flag = args[:flag]
  end

  def local_spares
    { flag: flag }
  end

  def default_chain
    "9-speed"
  end

  def default_tire_size
    "28"
  end
end

road_bike = RoadBike.new(size: "S", tape_color: "Blue")
p road_bike.size
p road_bike.spares

bent = RecumbentBike.new(flag: "tall and orange")
p bent.spares
