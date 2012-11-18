
require 'tmpdir'

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

