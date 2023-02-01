

/**
 *  MedianFinder class to calculate the median of a stream of numbers
 *
 *  - Properties
 *      - private var smallHeap: [Int] - small heap for storing smaller numbers
 *      - private var largeHeap: [Int] - large heap for storing larger numbers
 *
 *  - Methods
 *      addNum(num: Int) - adds a new number to the data structure
 *      - Complexity
 *          - Time: - `O(log n)`, where n is the number of elements in the large heap, this is because of the insert operation in the heap
 *      findMedian() -> Double - returns the median of all elements so far
 *      - Complexity
 *          - Time:  `O(1)`, this is because accessing the first elements of the heap is an `O(1)` operation
 *
 *  - Discussion
 *
 *  The MedianFinder class maintains two heaps, a large heap and a small heap.
 *
 *  The large heap stores the larger numbers in the data stream, and the small heap stores the smaller numbers, but negated.
 *
 *  This way, the first element of the large heap is always the largest number in the smaller half of the data, and the first element of the small heap,
 *  negated, is the largest number in the larger half of the data.
 *
 *  When a new number is added to the data structure, it is compared to the first element of the large heap. If the new number is smaller or equal,
 *  it is added to the small heap. If the new number is larger, it is added to the large heap.
 *
 *  If the number of elements in the large heap is larger than the number of elements in the small heap, the median is the first element of the large heap.
 *  If the number of elements in the large heap is smaller or equal to the number of elements in the small heap, the median is the mean of the first elements of both heaps.
 */
fileprivate class MedianFinder {

    private var smallHeap = [Int]()
    private var largeHeap = [Int]()

    func addNum(_ num: Int) {
        if largeHeap.count == 0 {
            largeHeap.append(num)
        } else if num <= largeHeap[0] {
            // append is O(1) operation, negating the value
            // maintains the correct order
            smallHeap.append(-num)
            if smallHeap.count > largeHeap.count {
                let num = -smallHeap.removeFirst()
                largeHeap.insert(num, at: 0)
            }
        } else {
            largeHeap.append(num)
            if largeHeap.count > smallHeap.count + 1 {
                let num = largeHeap.removeFirst()
                smallHeap.append(-num)
            }
        }
    }

    func findMedian() -> Double {
        if largeHeap.count > smallHeap.count {
            return Double(largeHeap[0])
        }
        return Double(largeHeap[0] - smallHeap[0]) / 2
    }
}

import XCTest

final class FindMedianFromDataStreamTests: XCTestCase {
    func test() {
        let finder = MedianFinder()
        finder.addNum(1)
        finder.addNum(2)
        XCTAssertEqual(finder.findMedian(), 1.5)
        finder.addNum(3)
        XCTAssertEqual(finder.findMedian(), 2.0)
    }
}
