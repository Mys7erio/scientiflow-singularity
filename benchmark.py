import threading
import time
import math
import sys


# Function to perform a CPU-intensive task: Check if a number is prime
def is_prime(n):
    if n <= 1:
        return False
    for i in range(2, int(math.sqrt(n)) + 1):
        if n % i == 0:
            return False
    return True

# Function that counts prime numbers up to a specified limit
def count_primes(limit):
    count = 0
    for i in range(2, limit):
        if is_prime(i):
            count += 1
    return count

# Thread target function to benchmark CPU
def cpu_benchmark(limit, thread_results, index):
    start_time = time.time()
    prime_count = count_primes(limit)
    end_time = time.time()
    thread_results[index] = (prime_count, end_time - start_time)

# Benchmarking function using multiple threads
def run_benchmark(limit, num_threads):
    threads = []
    thread_results = [None] * num_threads

    for i in range(num_threads):
        thread = threading.Thread(target=cpu_benchmark, args=(limit, thread_results, i))
        threads.append(thread)
        thread.start()

    for thread in threads:
        thread.join()

    # Display results
    for i, result in enumerate(thread_results):
        prime_count, duration = result
        print(f"Thread {i+1}: Found {prime_count} primes in {duration:.4f} seconds.")

if __name__ == "__main__":
    # Adjust these values as needed for a more or less intensive test
    limit = int(sys.argv[1]) if len(sys.argv) == 2 else 2000000  # Upper limit for prime calculation
    num_threads = 4  # Number of threads

    print("Running CPU benchmark...")
    run_benchmark(limit, num_threads)
