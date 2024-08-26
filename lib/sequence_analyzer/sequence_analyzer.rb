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
