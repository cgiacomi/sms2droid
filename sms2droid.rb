#!/usr/bin/env ruby

require 'sqlite3'
require 'cgi'


#message class
class Message
	attr_accessor :number, :text, :date, :flags, :group_id, :association_id
	
	def initialize(row)
	  @number = row['address']
	  @text = row['text']
	  @date = row['date']
	  @flags = row['flags']
	  @group_id = row['group_id']
	  @association_id = row['association_id']
	end
	
	#how each message should be represented in xml
	def to_xml
	  escaped_msg = CGI::escapeHTML("#{text}")
	  "    <sms protocol=\"0\" address=\"#{number}\" date=\"#{date}000\" type=\"#{flags-1}\" subject=\"null\" body=\"#{escaped_msg}\" toa=\"0\" sc_toa=\"0\" service_center=\"null\" read=\"1\" status=\"-1\" locked=\"0\" contact_name=\"Christian Giacomi\" />"
	end
end


#DO THE PROCESSING!

#will hold the extracted messages
messages = Array.new

#read from the DB
db = SQLite3::Database.new('/sms.db')
db.results_as_hash = true #otherwise you cannot referr to the columns via the column name!
db.execute( "select * from message" ) do |row|
	msg = Message.new(row)
	#puts msg.to_xml
	messages.push(msg)
end


# Create a new file and write to it  
File.open('messages.xml', 'w') do |file| 
	#add the header to the xml file
	file.puts "<?xml version='1.0' encoding='UTF-8' standalone='yes' ?>"
	file.puts "<smses count=\"#{messages.length}\">"

  #iterate over the messages and write the content   
  messages.each do |mess|
  	file.puts mess.to_xml
  end
  
  #add the footer
  file.puts "</smses>"
end  

#puts messages.length
puts "Processed #{messages.length} messages!"