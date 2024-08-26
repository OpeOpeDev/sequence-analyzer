require 'rspec'
require_relative '../solution'  # Adjust the path if needed

RSpec.describe SequenceAnalyzer do
  let(:file_path) { 'spec/test_file.txt' }
  let(:sequence_size) { 3 }
  let(:top_count) { 100 }

  before do
    File.open(file_path, 'w') do |file|
      file.write("hello world this is a test")
    end
  end

  after do
    File.delete(file_path)
  end

  describe '#process_files' do
    it 'processes files and outputs the top sequences' do
      analyzer = SequenceAnalyzer.new([file_path], sequence_size, top_count)
      output = StringIO.new
      $stdout = output

      analyzer.process_files

      $stdout = STDOUT
      output.rewind
      output_content = output.read

      expect(output_content).to include("hello world this - 1")
      expect(output_content).to include("world this is - 1")
      expect(output_content).to include("this is a - 1")
      expect(output_content).to include("is a test - 1")
    end

    it 'handles multiple files' do
      File.open('spec/test_file_2.txt', 'w') do |file|
        file.write("another file with different content")
      end

      analyzer = SequenceAnalyzer.new(['spec/test_file.txt', 'spec/test_file_2.txt'], sequence_size, top_count)
      output = StringIO.new
      $stdout = output

      analyzer.process_files

      $stdout = STDOUT
      output.rewind
      output_content = output.read

      expect(output_content).to include("hello world this - 1")
      expect(output_content).to include("world this is - 1")
      expect(output_content).to include("this is a - 1")
      expect(output_content).to include("is a test - 1")
      expect(output_content).to include("another file with - 1")
      expect(output_content).to include("file with different - 1")
      expect(output_content).to include("with different content - 1")

      File.delete('spec/test_file_2.txt')
    end

    it 'handles no files' do
      analyzer = SequenceAnalyzer.new([], sequence_size, top_count)
      output = StringIO.new
      $stdout = output

      analyzer.process_files

      $stdout = STDOUT
      output.rewind
      output_content = output.read

      expect(output_content).to eq("")
    end

    it 'handles files with empty content' do
      File.open('spec/empty_file.txt', 'w') do |file|
        file.write("")
      end

      analyzer = SequenceAnalyzer.new(['spec/empty_file.txt'], sequence_size, top_count)
      output = StringIO.new
      $stdout = output

      analyzer.process_files

      $stdout = STDOUT
      output.rewind
      output_content = output.read

      expect(output_content).to eq("")

      File.delete('spec/empty_file.txt')
    end
  end
end
