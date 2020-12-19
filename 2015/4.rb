require 'digest'

SECRET = 'yzbqklnj'
LENGTHS = [5, 6]

2.times do |part|
  number = 0
  while true
    digest = Digest::MD5.hexdigest(SECRET + number.to_s)
    if digest.start_with? '0' * LENGTHS[part]
      puts "Part #{1+part} solution: #{number}"
      break
    end
    # puts "  progress: #{number}" if number % 100_000 == 0
    number+=1
  end
end
