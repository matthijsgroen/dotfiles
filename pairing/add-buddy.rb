#!/usr/bin/env ruby

require 'optparse'
require 'ostruct'
require 'pp'
require 'open-uri'

settings = OpenStruct.new
settings.verbose = false
settings.target = '~/.ssh/authorized_keys'

parser = OptionParser.new do |opts|
  opts.banner = 'add-buddy GITHUB_NAME [options]'

  opts.separator ""
  opts.separator "Specific options:"
  opts.on("-t", "--target TARGET", "Add keys to target file") do |t|
    settings.target = t
  end

  opts.on("-v", "--[no-]verbose", "Run verbosely") do |v|
    settings.verbose = v
  end

  opts.separator ''
  opts.separator 'Common options:'

  opts.on_tail('-h', '--help', 'Show this message') do
    puts opts
    exit
  end
end

parser.parse! ARGV

if ARGV.size > 0
  settings.user = ARGV.pop
else
  puts parser
  exit
end

url = format('https://github.com/%s.keys', settings.user)
keys = []
open(url) do |io|
  io.each_line { |l| keys.push l.chomp }
end

puts "Found #{keys.size} keys for #{settings.user}" if settings.verbose

filepath = File.expand_path(settings.target)
f = open(filepath, 'a+')
begin
  f.rewind
  f.each_line do |existing_key|
    keys.each do |key|
      keys.delete key if existing_key.start_with? key
    end
  end
  keys.each do |key|
    f.puts format('%s github:%s', key, settings.user)
  end

  puts "Updated #{filepath}" if settings.verbose
ensure
  f.close
end

