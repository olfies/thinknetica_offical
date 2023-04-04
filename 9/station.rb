# frozen_string_literal: true

class Station
  @all = []

  attr_accessor :name,
                :trains,
                :cargo_train,
                :passenger_train

  def initialize(name)
    @name = name
    @trains = []
  end

  def each_train
    @trains.each { |train| yield(train) } if block_given?
    self
  end

  def add_train(train)
    @trains[train.type].push(train.num)
    puts "На станцию #{name} Прибыл поезд #{train.num}"
  end

  def delete_train(train)
    @trains[train.type].delete(train.num)
    puts "Со станции #{name} отбыл поезд #{train.num}"
  end

  def print_all_trains
    puts "На станции #{name} находятся грузовые поезда:"
    @trains[:cargo].each do |n|
      puts n.to_s
    end
    puts "На станции #{name} находятся пассажирские поезда:"
    @trains[:passenger].each do |n|
      puts n.to_s
    end
  end

  class << self
    attr_reader :all
  end
end
