require_relative 'lib/point'
require_relative 'lib/file_reader'
require_relative 'lib/plotter'
require_relative 'slink_cluster'

def insert_sorted arr, new_i
  for i in 0..arr.size-1
    if new_i < arr[i]
      arr.insert(i, new_i)
      return true
    end
  end
  arr.push new_i
  return true
end

unless ARGV.size == 2
  p "usage: ruby kmeans.rb <file_name> <k>"
  abort
end

# points = FileReader.read ARGV[0]
points    = FileReader.read "data/c2ds1-2sp.txt"
n         = points.size
k         = ARGV[1].to_i
clusters  = []

clusters  = SLinkCluster.init points # every point is a cluster at beginning
points    = nil

# round 1
dist_c = []
dist_i = []
for i in 0..clusters.size
  for j in i..clusters.size
    insert_sorted dist_i, Point.calc_distance clusters[i].mean_p, clusters[j].mean_p
  end
end
