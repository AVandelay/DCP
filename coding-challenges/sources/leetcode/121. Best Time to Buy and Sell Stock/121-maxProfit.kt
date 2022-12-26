fun main() {
    println(maxProfit(intArrayOf(7,1,5,3,6,4)) == 5)
    println(maxProfit(intArrayOf(7,6,4,3,1)) == 0)
}

fun maxProfit(prices: IntArray): Int {
    if (prices.isEmpty()) return 0
    
    var minPrice = prices.first()
    var maxProfit = 0
    
    for (price in prices.drop(1)) {
        minPrice = kotlin.math.min(minPrice, price)
        maxProfit = kotlin.math.max(maxProfit, price - minPrice)
    }
    
    return maxProfit
}