#!/usr/bin/env ruby

require "test-unit"
require "test/unit/notify"
require "test/unit/rr"

base_dir = File.expand_path(File.join(File.dirname(__FILE__), ".."))
lib_dir  = File.join(base_dir, "lib")
test_dir = File.join(base_dir, "test")
$LOAD_PATH.unshift(lib_dir)
$LOAD_PATH.unshift(test_dir)

require "pixlutter-test-utils"

exit Test::Unit::AutoRunner.run(true, test_dir)
