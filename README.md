# ImageJ Multi-Value Binary Mask Extractor

An ImageJ macro for batch processing 8-bit multi-plane stacks to extract binary masks for specific pixel values.

## Description

This macro processes an 8-bit image stack and automatically generates separate binary mask stacks for pixel values 1-119. Each output stack contains white pixels (value 255) where the original stack had the specific pixel value, and black pixels (value 0) everywhere else.

## Features

- **Fast batch processing**: Processes 119 different pixel values automatically
- **Optimized performance**: Uses ImageJ's native image operations instead of pixel loops
- **Batch mode**: Runs without GUI updates for maximum speed
- **Automatic file naming**: Saves files with zero-padded naming (e.g., `stack_value_001.tif`, `stack_value_002.tif`)
- **Binary output**: Creates clean binary masks (0 or 255) for easy analysis

## Usage

1. Open your 8-bit multi-plane stack in ImageJ
2. Run the macro: `Plugins → Macros → Run...`
3. Select the output directory when prompted
4. Wait for processing to complete (typically very fast even for large stacks)
5. Find 119 binary mask stacks in your chosen output directory

## Requirements

- ImageJ or Fiji
- 8-bit grayscale image stack (multi-plane)

## Output

- 119 TIFF stack files, one for each pixel value (1-119)
- Files named: `[original_name]_value_001.tif` through `[original_name]_value_119.tif`
- Each file is a binary mask showing where that specific pixel value occurred

## Use Cases

- Segmentation analysis
- Region of interest extraction
- Labeled image processing
- Cell or particle tracking with labeled stacks
