module LargeFileGenerator
  def self.generate_large_file(file1_path, file2_path, output_path, target_size_mb = 100, num_sentences = 100_000)
    content1 = File.read(file1_path, encoding: 'UTF-8')
    content2 = File.read(file2_path, encoding: 'UTF-8')
    
    words = process_words(content1, content2)
    
    synthetic_content = generate_synthetic_text(words, num_sentences)
    
    target_size_bytes = target_size_mb * 1024 * 1024
    
    generated_content = ""
    
    while generated_content.bytesize < target_size_bytes
      generated_content += synthetic_content
    end
    
    generated_content = generated_content.byteslice(0, target_size_bytes)
    
    File.open(output_path, 'w', encoding: 'UTF-8') do |file|
      file.write(generated_content)
    end
    
    puts "Large test file with processed words generated: #{output_path}"
  end

  def self.process_words(content1, content2)
    words = (content1 + " " + content2).downcase.gsub(/[[:punct:]]/, "").split
    words
  end

  def self.generate_synthetic_text(words, num_sentences)
    synthetic_text = ""
    
    num_sentences.times do
      sentence = words.sample(10).join(' ')
      synthetic_text += "#{sentence}.\n"
    end
    
    synthetic_text
  end
end
