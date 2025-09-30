// ImageJ Macro to extract pixels matching specific values from multi-plane stack
// Processes pixel values 1-119 and saves each result automatically

// Get the active image
origID = getImageID();
origTitle = getTitle();
getDimensions(width, height, channels, slices, frames);
Stack.getDimensions(width, height, channels, slices, frames);

// Check if it's an 8-bit image
if (bitDepth() != 8) {
    exit("Error: This macro requires an 8-bit image");
}

// Determine the number of planes
nPlanes = slices;
if (nPlanes == 1) {
    nPlanes = frames;
}

// Get output directory from user
outputDir = getDirectory("Choose output directory for filtered stacks");

print("=== Batch Processing Started ===");
print("Processing stack: " + origTitle);
print("Number of planes: " + nPlanes);
print("Dimensions: " + width + "x" + height);
print("Output directory: " + outputDir);
print("Processing pixel values 1-119...");
print("");

// Set batch mode for faster processing (no display updates)
setBatchMode(true);

// Process each pixel value from 1 to 119
for (refValue = 1; refValue <= 119; refValue++) {
    
    // Show progress
    showProgress(refValue, 119);
    
    // Duplicate the original stack
    selectImage(origID);
    run("Duplicate...", "duplicate");
    dupID = getImageID();
    
    // Create a binary mask where matching pixels = 255, others = 0
    selectImage(dupID);
    setThreshold(refValue, refValue);
    setOption("BlackBackground", true);
    run("Convert to Mask", "method=Default background=Dark black");
    run("8-bit");
    
    // Multiply: original * (mask/255) to keep only matching pixels
    imageCalculator("Multiply create stack", origID, dupID);
    resultID = getImageID();
    
    // Set the matching pixels to 255 (binary mask)
    selectImage(resultID);
    // The mask already has 255 where pixels match, but multiplied
    // by original values, so we just need to threshold to make binary
    setThreshold(1, 255);
    run("Convert to Mask", "method=Default background=Dark black");
    
    // Create filename with pixel value
    baseName = File.nameWithoutExtension;
    if (baseName == "") {
        baseName = "stack";
    }
    outputFilename = baseName + "_value_" + IJ.pad(refValue, 3) + ".tif";
    outputPath = outputDir + outputFilename;
    
    // Save the result
    selectImage(resultID);
    saveAs("Tiff", outputPath);
    close(); // Close result
    
    // Close the mask
    selectImage(dupID);
    close();
    
    // Print progress every 10 values
    if (refValue % 10 == 0) {
        print("Processed values 1-" + refValue + "...");
    }
}

// Turn off batch mode and show original image
setBatchMode(false);
selectImage(origID);

print("");
print("=== Processing Complete! ===");
print("119 filtered stacks saved to:");
print(outputDir);
print("Files named: " + baseName + "_value_001.tif through " + baseName + "_value_119.tif");