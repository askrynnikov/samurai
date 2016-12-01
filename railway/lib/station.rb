# frozen_string_literal: true
require_relative 'instance_counter'
require_relative 'train'
require_relative 'validation'
require_relative 'accessors'

# railroad station
class Station
  include InstanceCounter
  include Validation
  extend Accessors

  NAME_FORMAT = /[[:alpha:]]+/

  attr_reader :name, :trains
  attr_accessor_with_history :test1
  strong_attr_accessor :test2, String
  validate :name, :format, NAME_FORMAT
  @test_var_class1 = 'aaa'

  class << self
    @test_var_class2 = 'bbb'
    alias stations all
  end

  def initialize(name)
    @name = name
    @trains = []
    validate!
    register_instance
  end

  def print
    puts "\n#{name}"
    puts 'Trains:'
    print_trains
  end

  def print_trains
    each(&:print)
  end

  def each(&block)
    @trains.each(&block)
    self
  end

  def take_train(train)
    @trains << train unless train?(train)
    self
  end

  def send_train(train)
    train.go_next if train?(train)
    self
  end

  def departed_train(train)
    @trains.delete(train) unless train.at_station == self
    self
  end

  def numbers_trains
    @trains.map(&:number)
  end

  def amount_trains_by_type
    @trains.each_with_object(Hash.new(0)) { |sum, train| sum[train.type] += 1 }
  end

  def train?(train)
    @trains.include?(train)
  end

  def to_s
    name
  end
end
