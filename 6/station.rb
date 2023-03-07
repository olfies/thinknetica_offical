# frozen_string_literal: true

class Station
  @@all = []

  attr_accessor :name,
                :trains,
                :cargo_train,
                :passenger_train

  def initialize(name)
    @@all.push(self)
    @name = name
    @trains = {
      cargo: [],
      passenger: []
    }
    register_instance
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

  def self.all
    @@all
  end
end
