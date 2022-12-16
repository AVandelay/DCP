

func day1(_ nums: [Int], k: Int) -> Bool {
    var seen = Set<Int>()
    for num in nums {
        if seen.contains(k - num) {
            return true
        }

        seen.insert(num)
    }

    return false
}

func day1_binarySearch(_ nums: [Int], k: Int) -> Bool {
    let sorted = nums.sorted()
    var left = 0
    var right = sorted.count - 1
    while left < right {
        let sum = sorted[left] + sorted[right]
        if sum < k {
            left += 1
        } else if sum > k {
            right -= 1
        } else {
            return true
        }
    }
    return false
}
