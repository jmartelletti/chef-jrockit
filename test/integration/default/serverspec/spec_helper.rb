# encoding: utf-8
require 'serverspec'
require 'pathname'
require 'json'

@properties = JSON.parse(IO.read('/tmp/kitchen/dna.json'))

include Serverspec::Helper::Exec
include Serverspec::Helper::DetectOS

RSpec.configure do |c|
  c.before :all do
    c.os = backend(Serverspec::Commands::Base).check_os
  end
end
