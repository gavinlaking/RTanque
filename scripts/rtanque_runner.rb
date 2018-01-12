#!/usr/bin/env ruby

class RTanqueWizard
  def initialize; end

  def run
    prepare

    puts ''
    puts Colour.red { "RTanque Contestants:" }

    present
  end

  private

  def selected
    @bots.map do |bot|
      storage.fetch(bot)
    end
  end

  def present
    puts ''

    storage.each do |key, value|
      option = Colour.green { key.to_s }
      puts "(#{option}) #{sanitize(value)}"
    end

    puts ''
    puts 'Please select bot(s): (e.g. 1,2,3)'
  end

  def prepare
    filenames.map.with_index do |filename, index|
      index += 1
      storage[index] = filename
    end
    storage
  end

  def filenames
    Dir.glob(File.dirname(__FILE__) + '/../sample_bots/*.rb').select do |f|
      File.file?(f)
    end
  end

  def sanitize(value)
    value.gsub('./../sample_bots/', '').gsub('.rb', '')
  end

  def storage
    @storage ||= in_memory
  end

  def in_memory
    Hash.new { |hash, key| hash[key] = '' }
  end
end

class Colour
  def self.red(&_block)
    if block_given?
      "\e[31m" + yield + "\e[39m"
    end
  end

  def self.green(&_block)
    if block_given?
      "\e[33m" + yield + "\e[39m"
    end
  end
end

class RTanqueRunner
  def initialize(bots)
    @bots = bots.split(',').map(&:to_i)
  end

  def run
    puts "You selected: #{@bots.inspect}"

    exec "bundle exec rtanque start #{bots}"
  end

  private

  def bots

  end
end

args = ARGV[0]
if args
  RTanqueRunner.new(args).run
else
  RTanqueWizard.new.run
end
