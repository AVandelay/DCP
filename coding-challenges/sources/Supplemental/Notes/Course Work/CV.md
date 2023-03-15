<details>
<summary>Image processing basics</summary>

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
