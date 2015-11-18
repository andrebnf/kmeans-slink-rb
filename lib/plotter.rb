require 'nyaplot'

class Plotter
  def self.plot x, y, c
    df = Nyaplot::DataFrame.new({x:x,y:y,clusters:c})
    plot = Nyaplot::Plot.new
    colors = Nyaplot::Colors.qual

    sc = plot.add_with_df(df, :scatter, :x, :y)
    sc.tooltip_contents([:clusters])
    sc.color(colors)
    sc.fill_by(:clusters)

    plot.export_html
  end
end
