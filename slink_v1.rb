require_relative 'lib/point'
require_relative 'lib/file_reader'
require_relative 'lib/plotter'
require_relative 'slink_cluster_v1'

def insert_sorted arr, new_i
  for i in 0..arr.size-1
    if new_i < arr[i]
      arr.insert(i, new_i)
      return false
    end
  end
  arr.push new_i
  return false
end

unless ARGV.size == 2
  p "usage: ruby slink.rb <file_name> <k>"
  abort
end

# points = FileReader.read ARGV[0]
points, names = FileReader.read "data/" + ARGV[0]
# points    = FileReader.read "data/c2ds1-2sp.txt"
n         = points.size
k         = ARGV[1].to_i
clusters  = []

clusters  = SLinkCluster.init points # every point is a cluster at beginning
points    = nil

c1, c2 = 0, 1
min_dist = SLinkCluster.get_min_distance clusters[0], clusters[1]

while clusters.size != k
  for i in 0..clusters.size-1
    for j in i+1..clusters.size-1
      dist = SLinkCluster.get_min_distance clusters[i], clusters[j]
      if dist < min_dist
        min_dist = dist
        c1 = i
        c2 = j
      end
    end
  end

  p clusters.size
  clusters = SLinkCluster.merge clusters, c1, c2
end
