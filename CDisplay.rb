require 'rubygems'
require 'gosu'
require 'simul.rb'

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

  def initialize(res, size, rules, seed)
    @res = res
    @size = size

    super(res, res, false)
    @displayGrid = GraphicGrid.new self, @res, @size
    @simul = ConwayGame.new(size, rules, seed)
  end

  def update
    @simul.playRound
  end

  def draw
    #sleep 0.3
    @size.times.each do |x|
      @size.times.each do |y|
        it = @simul.grid.getItem(x, y)
        case it
          when 0
          @displayGrid.drawSquare(x, y, Gosu::black)
          when 1
          @displayGrid.drawSquare(x, y, Gosu::blue)
        end
      end
    end
  end

end

rules = {:under_population => 2, :over_population => 3, :survive => [2,3], :reproduction => 3}
seed = {[50,50] => 1, [50,52] => 1, [48,52] => 1, [47,54] => 1, [46, 54] => 1, [45,54] => 1, [46, 56] => 1, [45, 56] => 1, [44, 56] => 1, [45, 57] => 1}
#rules = {:dead => 4, :alive => 5, :alive2 => 2, :alive3 => 3} 
#rules = {:dead => 3, :alive => 5, :alive2 => 3, :alive3 => 3}
window = GameWindow.new 640, 100, rules, seed
window.show

