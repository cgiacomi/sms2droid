#!/usr/bin/env ruby

#
#  Copyright 2011 Christian Giacomi http://www.christiangiacomi.com
#
#  Licensed under the Apache License, Version 2.0 (the "License");
#  you may not use this file except in compliance with the License.
#  You may obtain a copy of the License at
#
#    http://www.apache.org/licenses/LICENSE-2.0
#
#  Unless required by applicable law or agreed to in writing, software
#  distributed under the License is distributed on an "AS IS" BASIS,
#  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
#  See the License for the specific language governing permissions and
#  limitations under the License.
#

#require 'rubygems'
require 'sqlite3'
require 'cgi'

#
#model class representing a sent or received sms
#
class Message
  attr_accessor :number, :text, :date

  def initialize(num, txt, dt)
    @number = num
    @text = txt
    @date = dt
  end

  #how each message should be represented in xml
  def to_xml
    "\t<sms protocol=\"0\" address=\"#{number}\" date=\"#{date}000\" date_sent=\"#{date}000\" type=\"1\" subject=\"null\" body=\"#{CGI::escapeHTML("#{text}")}\" toa=\"null\" sc_toa=\"null\" service_center=\"null\" read=\"1\" status=\"-1\" locked=\"0\" contact_name=\"null\" />"
  end
end

#
#write the messages to the xml file
#
def write_to_file(msgs)
  File.open('sms.xml', 'w') do |file|

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
  sql = """
   SELECT message.*, handle.id AS sender
   FROM message INNER JOIN handle ON message.handle_id = handle.ROWID
  """
  db.execute(sql) do |row|
    num = row['sender']
    txt = row['text']

    #convert MAC Absolute Time to unix epoch time.
    dt = row['date'].to_i + 978307200

    collection.push(Message.new(num, txt, dt))
  end

  return collection
end

def done(count)
  puts "\n[DONE] #{count} message(s) where extracted."
end

def exception
  puts "\n[FAILED] The file provided does not appear to be a valid iPhone sms.db backup file."
end

def file_not_found(filename)
  puts "\n[FAILED] The file #{filename} cannot be found! Please verify the path is correct and try again."
end

def bye
  puts("\nThank you for using 'sms2droid' by cgiacomi (http://github.com/cgiacomi/sms2droid)\n")
end



#
#DO THE WORK!
#
puts("\nsms2droid")
puts("pls enter the bsolute path of sms.db:")
file_to_convert = gets.chomp

if File.exists?(file_to_convert)
  messages = extract_from_db(file_to_convert)
  write_to_file(messages)
  done(messages.length)
else
  file_not_found(file_to_convert)
end

bye
