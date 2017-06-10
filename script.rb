#!/usr/bin/env ruby
# -*- coding: utf-8 -*-
require './env_updator'

env_updator = EnvUpdator.new

node = [
    # {major: 0},
    # {major: 4},
    # {major: 6},
    {major: 8}
]
env_updator.update('ndenv', node)

ruby = [
    # {major: 1, minor: 9},
    {major: 2, minor: 3}
]
env_updator.update('rbenv', ruby)
