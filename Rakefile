require 'rake/clean'
require 'fileutils'
projects = ['watir', 'firewatir', 'commonwatir']

desc "Generate all the Watir gems"
task :gems do
  projects.each do |x|
    Dir.chdir(x) {puts `rake.bat gem`}
  end
  FileUtils.makedirs 'gems'
  gems = Dir['*/pkg/*.gem']
  gems.each {|gem| FileUtils.install gem, 'gems'}
end

desc "Clean all the projects"
task :clean_subprojects do
  projects.each do |x|
    Dir.chdir(x) {puts `rake.bat clean`}
  end
end

task :clean => [:clean_subprojects]
CLEAN.add 'gems/*'

desc 'Run unit tests for IE'
task :test_ie do
  load 'watir/unittests/core_tests.rb'
end

desc 'Run unit tests for FireFox'
task :test_ff do
  load 'firewatir/unittests/mozilla_all_tests.rb' 
end

task :cruise => :test_ie
