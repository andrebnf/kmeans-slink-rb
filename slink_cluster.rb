require_relative 'lib/point'

class SLinkCluster
  attr_accessor :points, :mean_p
  def initialize
    @points = []
  end

  def self.init points
    clusters = []
    points.each do |p|
      c = self.new
      c.mean_p = p
      c.points << p
      clusters << c
    end
    return clusters
  end

  def merge cluster
  end
end
