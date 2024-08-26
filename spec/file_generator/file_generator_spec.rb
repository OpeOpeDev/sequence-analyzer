require 'rspec'
require_relative '../../lib/file_generator/file_generator'

RSpec.describe LargeFileGenerator do
  let(:file1_path) { 'spec/test_file1.txt' }
  let(:file2_path) { 'spec/test_file2.txt' }
  let(:output_path) { 'spec/test_large_file.txt' }

  before do
    File.open(file1_path, 'w') { |file| file.write("hello world") }
    File.open(file2_path, 'w') { |file| file.write("goodbye world") }
  end

  after do
    File.delete(file1_path)
    File.delete(file2_path)
    File.delete(output_path) if File.exist?(output_path)
  end

  describe '.generate_large_file' do
    it 'creates a file of the specified size with a small number of sentences for testing' do
      # Generate a small file for testing purposes
      LargeFileGenerator.generate_large_file(file1_path, file2_path, output_path, 0.1, 100) # 100 KB file with 100 sentences

      file_size_kb = File.size(output_path).to_f / 1024
      expect(file_size_kb).to be_within(10).of(100) # Allowing a 10 KB tolerance
    end
  end
end
