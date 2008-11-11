$SETUP_LOADED = true

$myDir = File.expand_path(File.dirname(__FILE__))

# use local development versions of watir, firewatir, commonwatir if available
topdir = File.join(File.dirname(__FILE__), '..')
$firewatir_dev_lib = File.join(topdir, '..', 'firewatir', 'lib')
$watir_dev_lib = File.join(topdir, '..', 'watir', 'lib')
$LOAD_PATH.unshift File.expand_path(File.join(topdir, 'lib'))

require 'watir/browser'
Watir::Browser.default = 'ie'
require 'unittests/setup/lib'

Dir.chdir topdir do
  $all_tests = Dir["unittests/*_test.rb"]
end
