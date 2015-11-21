require_relative 'lib/point'

class SLinkCluster

  def self.get_min_distance points, i1, i2
    p1 = []
    p2 = []
    min_dist = -1
    for i in 0..points.size-1
      if points[i].cluster_id == i1
        for j in i1+1..points.size-1
          if points[j].cluster_id == i2
            dist = Point.calc_distance points[i], points[j]
            min_dist = dist if min_dist == -1 || dist < min_dist
          end
        end
      end
    end
    # p p1.size
    # p p2.size
    #
    #
    # min_dist = Point.calc_distance p1[0], p2[0]
    # for i in 0..p1.size - 1
    #   for j in 0..p2.size - 1
    #     dist = Point.calc_distance p1[i], p2[j]
    #     min_dist = [dist, min_dist].min
    #   end
    # end
    min_dist
  end

  def self.merge points, i1, i2
    points.each do |p|
      if p.cluster_id == i2
        p.cluster_id = i1
      end
    end
    for i in i2..points.size-1
      points[i].cluster_id = i - 1
    end
    return
  end

end
