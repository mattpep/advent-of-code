require 'prime'

THRESHOLD = 36_000_000

def divisors number
  primes, powers = number.prime_division.transpose
  exponents = powers.map{|i| (0..i).to_a}
  divisors = exponents.shift.product(*exponents).map do |powers|
    primes.zip(powers).map{|prime, power| prime ** power}.inject(:*)
  end
  divisors.sort
end

# House 1 will have 10 gifts, but that's well below the threshold given to us.
house = 2
while true
  divs = divisors house
  # puts "Divisor sum is #{divs.sum}, divisors are #{divs}"
  break if divs.sum >= THRESHOLD/10
  house += 1
end

puts "Part 1: #{house}"
