require "byebug"

class Bicycle
  attr_reader :size, :parts

  def initialize(args)
    @size = args[:size]
    @parts = args[:parts]
  end

  # スペア情報をパーツクラスに移譲する
  def spares
    parts.spares
  end
end

class Parts
  attr_reader :parts

  def initialize(parts)
    @parts = parts
  end

  def spares
    parts.select { |part| part.needs_spare }
  end
end

# partsオブジェクトを作成するファクトリー
require "ostruct"

module PartsFacrtory
  def self.build(config, parts_class = Parts)
    parts_class.new(
      config.collect { |part_config|
        create_part(part_config)
      }
    )
  end

  def self.create_part(part_config)
    OpenStruct.new(
      name: part_config[0],
      description: part_config[1],
      needs_spare: part_config.fetch(2, true),
    )
  end
end

road_config = [["chain", "10-speed"],
               ["tire_size", "23"],
               ["tape_color", "red"]]

road_parts = PartsFacrtory.build(road_config)
p road_parts
