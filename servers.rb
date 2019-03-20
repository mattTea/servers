require "socket"

class Note
  attr_reader :title, :body
  
  def initialize(title, body)
    @title = title
    @body = body
  end
end

class Notebook
  attr_reader :notebook

  def initialize
    @notebook = []
  end
  
  def add(title, body)
    note = Note.new(title, body)
    @notebook << { :title => note }
  end
end

server = TCPServer.new(2345)

socket = server.accept

notebook = Notebook.new

while true do
  socket.puts "Note title"
  
  title = socket.gets.chomp
  
  socket.close if title == "quit"

  socket.puts "Note body"
  body = socket.gets.chomp

  socket.close if body == "quit"

  notebook.add(title, body)

  socket.puts "You note is: #{title}: #{body}" # <- puts string to Amy's laptop
  puts "Amy's note is: #{title}: #{body}" # <- puts to my laptop

  socket.puts "You have #{notebook.notebook.length} notes in your notebook"
end

# I run server 'ruby servers.rb'
# To get my ip address `ifconfig en0` in terminal
# Amy ran 'telnet' <my ip addres... 192.168.49.244> <my port... 2345>
# Access the prompts from this program and could interact and close the server