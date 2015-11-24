require_relative 'lib/point'
require_relative 'lib/file_reader'
require_relative 'lib/plotter'
require_relative 'slink_cluster'

# def insert_sorted arr, new_i
#   for i in 0..arr.size-1
#     if new_i < arr[i]
#       arr.insert(i, new_i)
#       return false
#     end
#   end
#   arr.push new_i
#   return false
# end

unless ARGV.size == 2
  p "usage: ruby slink.rb <file_name> <k>"
  abort
end

points, names = FileReader.read "data/" + ARGV[0], true
n         = points.size
ki        = n
k         = ARGV[1].to_i
clusters  = []
#
# points.each do |p|
#   p p.cluster_id
# end

# min_dist = SLinkCluster.get_min_distance points, 0, 1

while ki != k
  min_dist = -1
  c1 = c2 = -1

  for i in 0..(ki-1)
      p i
    for j in i+1..(ki-1)
      dist = SLinkCluster.get_min_distance points, i, j
      if min_dist == -1 || dist < min_dist
        min_dist = dist
        c1, c2 = i, j
      end
    end
  end

  SLinkCluster.merge points, c1, c2
  ki -= 1
  # points.each do |p|
  #   p p.cluster_id
  # end
end

out = ""
for i in 0..points.size-1
  out += names[i] + "\t" + points[i].cluster_id.to_s + "\n"
end

out_fn = ARGV[0].split(".")
out_fn = out_fn[0..out_fn.size-2].join(".")

File.open("./data_out_slink/#{out_fn}K_#{k}.out", 'w') { |file| file.write(out) }
