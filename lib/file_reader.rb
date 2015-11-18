require_relative 'point'

class FileReader
  def self.read file_name
    file = File.new(file_name, "r")
    points = []
    names = []
    line = file.gets # header
    while line = file.gets
      n = line.split("\t")[0]
      x = line.split("\t")[1]
      y = line.split("\t")[2].split("\n")[0]
      point = Point.new x.to_f, y.to_f
      points << point
      names  << n
    end
    return points, names
  end
end
