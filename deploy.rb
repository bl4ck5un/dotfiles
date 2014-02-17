#!/bin/ruby
# deploy config files in order
# to provide out-of-box experience on new distro

# --test        dry-run this scritps in $TEST_DIR
# --prefix      set root directory where config files go


require 'optparse'

options = {}
OptionParser.new do |opts|
    opts.banner = "Usage: deploy.rb [-t|--test] [--prefix PATH]"
    opts.on('-t', '--test', 'dry-run this scritps in PATH') do |t|
        options[:test] = t
    end
    opts.on('-d', '--debug', 'print a lot of debug info') do |d|
        options[:debug] = d
    end
    opts.on('--prefix PATH', 'set HOME directory') do |p|
        options[:prefix] = p
    end
end.parse!

p options
p ARGV
