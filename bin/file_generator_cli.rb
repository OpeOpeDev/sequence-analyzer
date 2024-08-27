#!/usr/bin/env ruby

require_relative '../lib/file_generator/file_generator'

file1_path = 'data/pride_and_prejudice.txt'
file2_path = 'data/sense_and_sensibility.txt'
output_path = 'data/large_test_file.txt'

# You can specify the target file size in MB and the number of sentences here
target_size_mb = 10  # Set desired file size in MB
num_sentences = 100_000  # Number of sentences to generate

LargeFileGenerator.generate_large_file(file1_path, file2_path, output_path, target_size_mb, num_sentences)
