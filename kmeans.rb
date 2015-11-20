require_relative 'lib/point'
require_relative 'lib/file_reader'
require_relative 'lib/plotter'
require_relative 'kmeans_cluster'

unless ARGV.size == 2
  p "usage: ruby kmeans.rb <file_name> <k>"
  abort
end

# points, names = FileReader.read "data/c2ds1-2sp.txt"
points, names = FileReader.read "data/" + ARGV[0]
clusters  = []
n         = points.size
k         = ARGV[1].to_i

first_c = 0
# choose k first centroids from data
(n/(n/k)).times do
  c = KMeansCluster.new points[first_c] # initialize clusters with arbitrary centroid
  clusters << c
  first_c += n/k
end

KMeansCluster.classify points, clusters

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

File.open("./data_out_kmeans/#{out_fn}K_#{k}.out", 'w') { |file| file.write(out) }
