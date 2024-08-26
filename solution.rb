module TextProcessor
  def self.clean_text(text)
    text.downcase.gsub(/[[:punct:]]/, "").gsub(/\s+/, " ").strip
  end

  def self.extract_sequences(text, sequence_size)
    words = text.split
    sequences = []
    (0..words.length - sequence_size).each do |i|
      sequences << words[i, sequence_size].join(' ')
    end
    sequences
  end

  def self.count_sequences(sequences)
    sequence_count = Hash.new(0)
    sequences.each { |sequence| sequence_count[sequence] += 1 }
    sequence_count
  end
end

class SequenceAnalyzer
  def initialize(file_paths, sequence_size = 3, top_count = 100)
    @file_paths = file_paths
    @sequence_size = sequence_size
    @top_count = top_count
  end

  def process_files
    sequence_count = Hash.new(0)

    @file_paths.each do |file_path|
      content = File.read(file_path)
      cleaned_text = TextProcessor.clean_text(content)
      sequences = TextProcessor.extract_sequences(cleaned_text, @sequence_size)
      sequence_count.merge!(TextProcessor.count_sequences(sequences)) { |key, old_val, new_val| old_val + new_val }
    end

    top_sequences = sequence_count.sort_by { |_, count| -count }.first(@top_count)

    top_sequences.each do |sequence, count|
      puts "#{sequence} - #{count}"
    end
  end
end

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
