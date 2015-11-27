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

if ARGV.size < 2
  p "usage: ruby slink.rb <file_name> <k> [<k_interval>]"
  abort
end

# points = FileReader.read ARGV[0]
points, names = FileReader.read "data/" + ARGV[0], true
# points    = FileReader.read "data/c2ds1-2sp.txt"
n         = points.size
k         = ARGV[1].to_i
k2        = ARGV[2].to_i
k2 = k if k2 == 0
clusters  = []

clusters  = SLinkCluster.init points # every point is a cluster at beginning

c1, c2 = -1, -1

while clusters.size != k
  min_dist = -1
  for i in 0..clusters.size-1
    for j in i+1..clusters.size-1
      dist = SLinkCluster.get_min_distance clusters[i], clusters[j]
      if dist < min_dist || min_dist == -1
        min_dist = dist
        c1 = i
        c2 = j
      end
    end
  end


  clusters = SLinkCluster.merge clusters, c1, c2
  p clusters.size

  if clusters.size <= k2 && clusters.size >= k

    x = []
    y = []
    c = []
    points.each do |p|
      x << p.x
      y << p.y
      c << p.cluster_id
    end

    Plotter.plot x, y, c

    out = ""
    for i in 0..points.size-1
      out += names[i] + "\t" + points[i].cluster_id.to_s + "\n"
    end

    out_fn = ARGV[0].split(".")
    out_fn = out_fn[0..out_fn.size-2].join(".")

    File.open("./data_out_slink/#{out_fn}K_#{clusters.size}.out", 'w') { |file| file.write(out) }

  end
end
