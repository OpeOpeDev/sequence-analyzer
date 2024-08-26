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
