%w{irb/completion pp}.each do |lib|
  require lib
end

ARGV.concat [ '--readline' ]
