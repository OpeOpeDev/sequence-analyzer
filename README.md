# Text Sequence Analyzer

## Overview

The Text Sequence Analyzer is a Ruby command-line tool that analyzes one or more text files to find the 100 most common three-word sequences.

## Purpose of This Note

This README provides an overview of the project, outlines problems faced, and solutions implemented to the code.

## Requirements

- **Command-Line Execution**: The program runs from the command line and accepts one or more file paths. `Achieved`
- **Output**: It shows the 100 most common three-word sequences from the text files. `Achieved`
- **Text Processing**: The program ignores punctuation, line endings, and is not case-sensitive. `Achieved`
- **Testing**: A test suite is included to check the program's functionality. `Achieved`

## How to Run the Project

1. **Clone the Project**

   Run the following command in command line or terminal.

   ```
    git clone https://github.com/crazyfullstack/sequence-analyzer.git
   ```

1. **Ensure Ruby is Installed**

   Make sure Ruby 3.3.4 is installed on your system.  
   If not, please visit [Ruby Installation](https://www.ruby-lang.org/en/documentation/installation/).

1. **Run the Text Sequence Analyzer**:

   Run the script with one or more file paths in command line or terminal.  
   For example:

   ```
   cd path/to/your/project
   ruby solution.rb pride_and_prejudice.txt sense_and_sensibility.txt
   ```

1. **View the Output**

   The script will display the 100 most common three-word sequences and their counts in the console.  
   For example:

   ```
    i am sure - 129
    as soon as - 114
    i do not - 106
    ...
   ```

1. **Generate Large Test File (Optional)**

   - To test performance with large files, use the `generate_large_file.rb` script.

   - Run the script to create a large test file:
     ```
     ruby generate_large_file.rb
     ```
   - This will create a file named `large_test_file.txt` for testing.
   - Then, run the following command.
     ```
     ruby solution.rb large_test_file.txt
     ```

## Testing

A test suite is provided in the folder named `spec` using Rspec to ensure the program works correctly:

- **`test_processor_spec.rb`**: Tests the `TextProcessor` module for cleaning text, extracting sequences, and counting.
- **`sequence_analyzer_spec.rb`**: Tests the `SequenceAnalyzer` class using temporary files.

To run the tests, follow the steps below.

- [Install Rspec.](https://rspec.info/documentation/)

- Run tests.

  ```
  rspec
  ```

## Problems and Solutions

### 1. Text Cleaning

- **Problem**: Text cleaning varies based on use. Some characters from German or non-Latin languages may not be handled well.

- **Solution**: A simple cleaning method that ignores punctuation was created with for ease for updates.

### 2. Reducing Complexity

- **Problem**: The project had high complexity.

  **Time Complexity**: `O(f ⋅ n + m log m)`

  **Space Complexity**: `O(f ⋅ n + m)`

  where `f` is the number of files, `n` is the average file size, and `m` is the number of sequences.

  Here, `m` is much smaller than `n`, so the major time-consuming part is cleaning, extracting and counting.

  ```sh
  $ ruby solution.rb large_test_file.txt
  Time to read large_test_file.txt: 0.0099309 seconds
  Time to clean text: 0.9742052 seconds
  Time to extract sequences: 1.2264264 seconds
  Time to count sequences: 0.5357073 seconds
  Time to sort and get top sequences: 0.010531 seconds
  ```

- **Solution**:
  While smart algorithms for sorting such as heaps, are not suitable here, finding better algorithms for cleaning, extracting, and counting could enhance performance. Modularized code is designed to easily incorporate new algorithms.

### 3. Testing with Large Files

- **Problem**: It is needed to ensure the program works well with large files.

- **Solution**: Created `generate_large_file.rb` to generate large test files by combining text. This helps test performance. Additionally, processing files in chunks instead of loading everything at once could improve memory management and speed.

### 4. Flexible Sequence Length

- **Problem**: The program only extracts three-word sequences.

- **Solution**: The code can be easily modified to handle different sequence size.

  ```ruby
  def initialize(file_paths, sequence_size = 3, top_count = 100)
  ```

## Final Notes

Thank you for reviewing this project. I appreciate the opportunity to tackle this interesting problem. Your feedback and suggestions for improvement are welcome.
