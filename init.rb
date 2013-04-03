at_exit do
  require "irb"
  require "drb/acl"
end

unless defined?(Ocra)
  load "script/exe_server.rb"
end