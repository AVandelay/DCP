

func findFirstMissingPositive(_ nums: [Int]) -> Int {
    let nums = Set(nums)

    var i = 1
    while nums.contains(i) {
        i += 1
    }

    return i
}
