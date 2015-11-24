require_relative 'lib/point'

class SLinkCluster
  attr_accessor :points, :points_ids
  def initialize
    @points = []
    @points_ids = []
  end

  def self.init points
    clusters = []
    points.each do |p|
      c = self.new
      c.points << p
      clusters << c
    end
    return clusters
  end

  def self.get_min_distance c1, c2
    p1 = c1.points
    p2 = c2.points

    min_dist = Point.calc_distance p1[0], p2[0]
    for i in 0..p1.size-1
      for j in 0..p2.size-1
        dist = Point.calc_distance p1[i], p2[j]
        min_dist = [dist, min_dist].min
      end
    end
    min_dist
  end

  def self.merge clusters, i1, i2
    clusters[i2].points.each do |p|
      clusters[i1].points << p
      p.cluster_id = i1
    end

    clusters.delete_at i2
    return clusters
  end

end
