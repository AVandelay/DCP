import java.util.concurrent.Executors
import java.util.concurrent.ScheduledExecutorService
import java.util.concurrent.TimeUnit

fun main() {
    val scheduler = JobScheduler()
    
    val startTime = System.currentTimeMillis()
    
    scheduler.schedule({
        val endTime = System.currentTimeMillis()
        val elapsedTime = endTime - startTime
        println("Elapsed time: $elapsedTime milliseconds. Expected 1000 milliseconds")
    }, 1000)
}

class JobScheduler {
    private val executor: ScheduledExecutorService = Executors.newSingleThreadScheduledExecutor()
    
    fun schedule(f: () -> Unit, after: Long) {
        executor.schedule(f, after, TimeUnit.MILLISECONDS)
    }
}