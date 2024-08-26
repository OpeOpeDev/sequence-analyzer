require 'rspec'
require_relative '../solution'  # Adjust the path if needed

RSpec.describe TextProcessor do
  describe '.clean_text' do
    it 'removes punctuation and extra spaces and converts text to lowercase' do
      text = "Hello, World!  This is a test."
      cleaned_text = TextProcessor.clean_text(text)
      expect(cleaned_text).to eq("hello world this is a test")
    end

    it 'handles an empty string' do
      text = ""
      cleaned_text = TextProcessor.clean_text(text)
      expect(cleaned_text).to eq("")
    end

    it 'handles text with only punctuation' do
      text = "!!!,,,;;;---"
      cleaned_text = TextProcessor.clean_text(text)
      expect(cleaned_text).to eq("")
    end

    it 'handles text with only spaces' do
      text = "    "
      cleaned_text = TextProcessor.clean_text(text)
      expect(cleaned_text).to eq("")
    end

    it 'handles text with leading and trailing spaces' do
      text = "  Hello, World!  "
      cleaned_text = TextProcessor.clean_text(text)
      expect(cleaned_text).to eq("hello world")
    end
  end

  describe '.extract_sequences' do
    it 'extracts sequences of the given size from the text' do
      text = "hello world this is a test"
      sequences = TextProcessor.extract_sequences(text, 3)
      expect(sequences).to eq([
        "hello world this",
        "world this is",
        "this is a",
        "is a test"
      ])
    end

    it 'returns an empty array when the sequence size is larger than the number of words' do
      text = "short text"
      sequences = TextProcessor.extract_sequences(text, 10)
      expect(sequences).to eq([])
    end

    it 'returns an empty array for an empty string' do
      text = ""
      sequences = TextProcessor.extract_sequences(text, 3)
      expect(sequences).to eq([])
    end

    it 'handles sequences of size 1' do
      text = "a b c"
      sequences = TextProcessor.extract_sequences(text, 1)
      expect(sequences).to eq(["a", "b", "c"])
    end
  end

  describe '.count_sequences' do
    it 'counts occurrences of each sequence' do
      sequences = [
        "hello world this",
        "world this is",
        "this is a",
        "hello world this",
        "is a test"
      ]
      count = TextProcessor.count_sequences(sequences)
      expect(count).to eq({
        "hello world this" => 2,
        "world this is" => 1,
        "this is a" => 1,
        "is a test" => 1
      })
    end

    it 'returns an empty hash for an empty array' do
      sequences = []
      count = TextProcessor.count_sequences(sequences)
      expect(count).to eq({})
    end
  end
end
