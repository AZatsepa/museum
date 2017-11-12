class ComparisonController < ApplicationController
  def index; end

  def fortress_1782
    render 'comparison/1782_1943'
  end

  def city_1943
    render 'comparison/1943_2017'
  end

  def fortress_on_2017
    render 'comparison/1782_2017'
  end
end
