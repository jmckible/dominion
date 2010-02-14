module Dominion
  class Input

    def self.get_boolean(socket, prompt)
      socket.puts "#{prompt} (Y/n)"
      answer = socket.gets.chomp
      while !['y', 'n', ''].include?(answer.downcase)
        socket.puts "Didn't get that. Please enter 'Y' or 'N'"
        socket.puts "#{prompt} (Y/n)"
        answer = socket.gets.chomp.downcase
      end
      answer == 'y' || answer == ''
    end
    
    def self.get_integer(socket, prompt, lower, upper)
      socket.puts "#{prompt} (#{lower}-#{upper})"
      integer = socket.gets.chomp
      integer = integer.to_i
      while integer < lower || integer > upper
        socket.puts "Please enter a number between #{lower} and #{upper}"
        integer = socket.gets.chomp
        integer = integer.to_i
      end
      integer
    end
    
  end
end