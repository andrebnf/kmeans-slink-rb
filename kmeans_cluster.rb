require_relative 'lib/point'

class KMeansCluster
  attr_accessor :points, :centroid, :prev_centroid

  def initialize c_point
    @points = []
    @centroid = c_point
  end

  def reajust_centroid
    s_x, s_y = 0, 0
    @points.each do |p|
      s_x += p.x
      s_y += p.y
    end
    s_x /= @points.size
    s_y /= @points.size

    @prev_centroid = @centroid
    @centroid = Point.new s_x, s_y
  end

  # run until iterations reach 150 or until centroids dont change
  def self.classify points, clusters
    not_converged, iterations = true, 0

    while not_converged
      changed = false

      # reseting points on cluster
      clusters.each do |c|
        c.points = []
      end

      points.each do |p|
        min_dist = -1
        nearest_c = -1

        i = 0
        clusters.each do |c|
          # calc dist from p for each cluster
          dist = Point.calc_distance p, c.centroid

          if min_dist == -1 # min_dist is initialized with -1
            min_dist = dist # first distance calculed
            nearest_c = i # first cluster
          elsif dist < min_dist
            min_dist = dist # update min dist
            nearest_c = i # update cluster
          end
          i += 1
        end
        # assign point to closest cluster
        p.cluster_id = nearest_c
        clusters[nearest_c].points << p
      end
      not_changed = true
      # readjusting centroids and checking changes
      clusters.each do |c|
        c.reajust_centroid
        not_changed = (c.prev_centroid == c.centroid) && not_changed
      end

      # optimizations
      iterations += 1
      not_converged = false if iterations >= 150
      not_converged = false if not_changed
    end
  end
end
