

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
