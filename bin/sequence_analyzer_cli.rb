#!/usr/bin/env ruby

require_relative '../lib/sequence_analyzer/sequence_analyzer'
require_relative '../lib/sequence_analyzer/text_processor'

if ARGV.empty?
  puts "You need to choose at least one file."
else
  start_time = Time.now
  analyzer = SequenceAnalyzer.new(ARGV)
  analyzer.process_files
  end_time = Time.now
  elapsed_time = end_time - start_time

  puts "Elapsed time: #{elapsed_time} seconds"
end
