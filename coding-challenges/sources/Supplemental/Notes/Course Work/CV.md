<details>
<summary>
<b>Image processing basics</b>
<br>Image processing is an essential component of computer vision and involves manipulating digital images to enhance their quality, extract information, or perform some analysis.
</summary>

## Image representation and formats:
Digital images can be represented in various formats, such as grayscale, RGB, and HSV. Grayscale images have a single channel representing the intensity of light, while RGB images have three channels (red, green, and blue) that combine to create a wide range of colors. HSV (hue, saturation, value) is another color space that separates color information (hue) from the intensity (value) and saturation, making it easier to work with in some applications.

## Image filtering:
Image filters are used to perform various operations, such as smoothing, sharpening, or removing noise. Common filters include:

- Gaussian filter: A low-pass filter that smooths the image by blurring it with a Gaussian function. It helps reduce noise and smoothen out textures.
- Median filter: A non-linear filter that replaces each pixel's value with the median value of the neighboring pixels. It's particularly effective in removing salt-and-pepper noise while preserving edges.
- Laplacian filter: A second-order derivative filter that highlights regions with rapid intensity changes, often used for edge detection or image sharpening.

## Edge detection:
Edges are significant local changes in pixel intensity and represent object boundaries. Common edge detection techniques include:

- Canny edge detector: A multi-stage edge detection algorithm that involves smoothing, calculating gradients, non-maximum suppression, and thresholding with hysteresis. It produces thin, well-connected edges.
- Sobel operator: A pair of 3x3 convolution kernels that approximate the gradient of the image intensity in the horizontal and vertical directions. The magnitude of the gradient helps identify the edges.
- Prewitt operator: Similar to the Sobel operator, but with slightly different convolution kernels.

## Image transformation:
Image transformations involve changing the spatial arrangement of pixels in an image. Common transformations include:

- Scaling: Changing the size of the image by increasing or decreasing the number of pixels. Interpolation techniques like nearest-neighbor, bilinear, and bicubic are used to estimate the values of new pixels.
- Rotation: Rotating the image around a specified point by a given angle. This operation requires resampling the image and can cause aliasing artifacts.
- Translation: Shifting the image by a certain amount in the x and y directions. This operation can be used for tasks like image alignment or registration. 
</details>

<details>
<summary>
<b>Feature extraction and description:</b>
<br>These techniques are used to identify and describe distinctive points or regions in images, which can be used for tasks like object recognition, image matching, and tracking.
</summary>

## Histogram of Oriented Gradients (HOG):
HOG is a feature descriptor that captures the distribution of local intensity gradients in an image. It divides the image into small cells, computes the gradient histogram for each cell, and normalizes the histograms using overlapping blocks. HOG features are robust to changes in illumination and pose. They are widely used for object detection, particularly for human detection.

### Advantages:
- Robust to changes in illumination and pose
- Effective for detecting objects with a well-defined shape

### Limitations:
- Sensitive to changes in scale and rotation
- May not perform well for textureless objects

## Scale-Invariant Feature Transform (SIFT):
SIFT is a keypoint detector and descriptor that is invariant to image scale, rotation, and partially invariant to changes in illumination and viewpoint. The algorithm detects keypoints by identifying local extrema in the Difference of Gaussians (DoG) scale-space, assigns orientations, and computes a 128-dimensional descriptor based on gradient histograms.

### Advantages:
- Invariant to scale, rotation, and partially invariant to illumination and viewpoint changes
- Highly distinctive descriptors

### Limitations:
- Relatively slow and computationally expensive
- May not perform well in real-time applications

## Speeded Up Robust Features (SURF):
SURF is an improvement over SIFT that aims to be faster and more efficient while maintaining similar performance. It uses integral images to speed up the computation of the Hessian matrix for scale-space extrema detection and employs a simple descriptor based on Haar wavelets.

### Advantages:
- Faster and more efficient than SIFT
- Invariant to scale, rotation, and partially invariant to illumination and viewpoint changes

### Limitations:
- Less distinctive than SIFT descriptors
- Still slower than some other modern feature extraction techniques

## Binary Robust Invariant Scalable Keypoints (BRISK):
BRISK is a binary descriptor that is fast and rotation-invariant. It detects keypoints using a scale-space FAST (Features from Accelerated Segment Test) corner detector and computes the descriptor by comparing the intensities of pairs of pixels in a circular pattern around the keypoint.

### Advantages:
- Fast and computationally efficient
- Rotation-invariant and partially scale-invariant

### Limitations:
- Less distinctive than SIFT and SURF descriptors
- Not fully scale-invariant

## ORiented BRIef (ORB):
ORB is another fast binary descriptor that combines the FAST keypoint detector and the BRIEF descriptor. It adds a rotation-invariant property to BRIEF by steering the descriptor based on the keypoint's orientation, estimated using intensity centroid.

### Advantages:
- Fast and computationally efficient
- Rotation-invariant and partially scale-invariant

### Limitations:
- Less distinctive than SIFT and SURF descriptors
- Not fully scale-invariant
</details>


<details>
<summary>
<b></b>
<br>
</summary>


</details>
