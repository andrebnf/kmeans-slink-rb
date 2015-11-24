require_relative 'lib/point'

class SLinkCluster

  def self.get_min_distance points, i1, i2
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
