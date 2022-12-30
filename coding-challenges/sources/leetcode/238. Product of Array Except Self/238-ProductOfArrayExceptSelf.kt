import java.util.Arrays

fun main() {
    println(Arrays.toString(productArray(intArrayOf(1,2,3,4))))
    println(Arrays.toString(productArray(intArrayOf(-1,1,0,-3,3))))
}

fun productArray(nums: IntArray): IntArray {
    val prefixProducts = nums.foldIndexed(MutableList(nums.size) { 1 }) { i, acc, x ->
        acc[i] = if (i == 0) x else acc[i - 1] * x
        acc
    } 
    
    val suffixProducts = nums.foldRightIndexed(MutableList(nums.size) { 1 }) { i, x, acc ->
        acc[i] = if (i == nums.lastIndex) x else acc[i + 1] * x
        acc
    }
    
    return nums.foldIndexed(IntArray(nums.size) { 1 }) { i, acc, _ ->
        acc[i] = if (i == 0) {
            suffixProducts[i + 1] 
        } else if (i == nums.lastIndex) {
            prefixProducts[i - 1]
        } else {
            prefixProducts[i - 1] * suffixProducts[i + 1]
        }
        acc
    }
}