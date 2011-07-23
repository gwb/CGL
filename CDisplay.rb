require 'rubygems'
require 'gosu'

class GraphicGrid
  attr_accessor :grid

  def initialize(window, res, size)
    @res = res
    @size = size
    @window = window
    
    # Setup the grid
    @grid = []
    step = @res / @size
    @size.times do |i|
      line = []
      @size.times do |j|
        line << [[i*step,j*step], [i*step, (j+1)*step], [(i+1)*step, (j+1)*step], [(i+1)*step, j*step]]
      end
      @grid << line
    end
  end

  def drawSquare(j, i, color)
    # Note that i and j are reversed to mimic the classic x and y order
    args = [@grid[i][j][0], color, @grid[i][j][1], color, @grid[i][j][2], color, @grid[i][j][3], color].flatten
    @window.draw_quad(*args)
  end
end 


class GameWindow < Gosu::Window
  def initialize(res, size)
    @res = res
    @size = size

    super(res, res, false)
    @displayGrid = GraphicGrid.new self, @res, @size

    @ci = 0
    @cj = 0
  end

  def update
    if @ci < @size - 1
      @ci += 1
    end
  end

  def draw
    @displayGrid.drawSquare(@ci, @cj, Gosu::blue)
  end
end

window = GameWindow.new 640, 10
window.show

