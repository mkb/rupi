
require 'tmpdir'

# make sure we're on master and git cache isn't dirty

task :release do
  Dir.mktmpdir do |dir|
    temp_location = "#{dir}/setup"
    FileUtils.copy_file('setup.sh', temp_location)
    `git checkout gh-pages`
    FileUtils.copy_file(temp_location, 'setup')
    `git add setup`
    `git commit -m "release #{Time.now}"`
    `git checkout -`
  end
end

task :build do
  File.open('setup.sh', 'w') do |setup|
    funcs = File.read('setup/functions.sh')
    setup.write(funcs)
    parts = Dir.new('setup')
    parts.each do |part|
      next unless part.match(/^\d\d_.*\.sh$/)
      setup.write(File.read('setup/' + part))
    end
  end
end

# 1.9.3-p327 :004 > s.each {|f| if f.match(/^\d\d_.*\.sh$/)
# 1.9.3-p327 :005?>     puts 'gug'
# 1.9.3-p327 :006?>     else
# 1.9.3-p327 :007 >       puts f
# 1.9.3-p327 :008?>     end
# 1.9.3-p327 :009?>   }
