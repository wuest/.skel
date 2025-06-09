# frozen_string_literal: true

homedir = File.join(Dir.home, '.irb')
$LOAD_PATH.unshift(homedir) if Dir.exist?(homedir)

%w[irb/completion pp json base64].each do |lib|
  require lib
end

ARGV.push('--readline') unless ARGV.include?('--readline')
