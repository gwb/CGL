require 'rubygems'
require 'gosu'

class GameWindow < Gosu::Window
  def initialize(resolution, size)
    super(resolution, resolution, false)
    self.caption = "Gosu Display Test"
    @resolution = resolution
    @size = size
    @ci = 0
    @cj = 0
    @displayArray = createDisplayArray(Gosu::blue)
  end

  def createDisplayArray(color)
    step = @resolution / @size
    displayArray = []
    @size.times do |i|
      line = []
      @size.times do |j|
        line << [i*step,j*step,color, i*step, (j+1)*step, color, (i+1)*step, (j+1)*step, color, (i+1)*step, j*step, color]
      end
      displayArray << line
    end
    return displayArray
  end

  def drawSquare(i,j)
    self.draw_quad(*@displayArray[i][j])
  end

  def update
    if @ci < @size - 1
      @ci = @ci + 1
    end
  end

  def draw
    #self.draw_quad(0,0,Gosu::blue, 0, 20, Gosu::blue, 20,20, Gosu::blue, 20, 0, Gosu::blue)
    self.drawSquare(@ci, @cj)
  end
end

window = GameWindow.new 640, 10
window.show
