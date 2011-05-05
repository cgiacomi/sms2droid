#!/usr/bin/env ruby

#
#	  Copyright 2011 Christian Giacomi http://www.christiangiacomi.com
# 
#   Licensed under the Apache License, Version 2.0 (the "License");
#   you may not use this file except in compliance with the License.
#   You may obtain a copy of the License at
# 
#     http://www.apache.org/licenses/LICENSE-2.0
# 
#   Unless required by applicable law or agreed to in writing, software
#   distributed under the License is distributed on an "AS IS" BASIS,
#   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
#   See the License for the specific language governing permissions and
#   limitations under the License.
#

require 'sqlite3'
require 'cgi'




#
#model class
#
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

#
#write the messages to the xml file
#
def write_to_file(msgs)
	File.open('messages.xml', 'w') do |file| 
		
		#add the header to the xml file
		file.puts "<?xml version='1.0' encoding='UTF-8' standalone='yes' ?>"
		file.puts "<smses count=\"#{msgs.length}\">"
	
		#iterate over the messages and write the content   
		msgs.each do |msg|
			file.puts msg.to_xml
		end
		
		#add the footer
		file.puts "</smses>"
	end  
end

#
#extracts the values from the DB
#
def extract_from_db(dbfilepath)	
	collection = Array.new
	
	db = SQLite3::Database.new("#{dbfilepath}")
	db.results_as_hash = true #otherwise you cannot referr to the columns via the column name!
	
	db.execute( "select * from message" ) do |row|
		msg = Message.new(row)
		#puts msg.to_xml
		collection.push(msg)
	end
	
	return collection
end





#
#DO THE PROCESSING!
#
puts("\n\nsms2droid")
puts("Please provide sms.db path:")
file_to_convert = gets.chomp

if File.exists?(file_to_convert)
	messages = extract_from_db(file_to_convert)
	write_to_file(messages)	
	puts "\n[DONE] #{messages.length} message(s) where extracted."
else
  puts "\n[FAILED] The file #{file_to_convert} cannot be found! Please verify the path is correct and try again."
end

puts("\nThank you for using 'sms2droid' by cgiacomi (http://github.com/cgiacomi/sms2droid)\n")




