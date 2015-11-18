class Point
  # c_dist is the distance from this point to its closes cluster centroid
  attr_accessor :x, :y, :cluster_id

  def initialize x, y
    @x, @y = x, y
  end

  def self.calc_distance p1, p2
    return Math.sqrt(((p1.x - p2.x) ** 2) + ((p1.y - p2.y) ** 2))
  end

  def ==(point)
    if @x.round(3) == point.x.round(3) && @y.round(3) == point.y.round(3)
      return true
    else
      return false
    end
  end
end
