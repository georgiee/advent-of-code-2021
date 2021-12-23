require 'benchmark'
require 'stringio'
require "enumerator"
require 'set'

HALLWAY = (0..11).to_a.map{[[_1, 0], nil]}.flatten(1)
ROOM_A = [[2,1], "D", [2,2], "C"]
ROOM_B = [[4,1], "C", [4,2], "D"]
ROOM_C = [[6,1], "A", [6,2], "A"]
ROOM_D = [[8,1], 'B', [8,2], 'B']

coords = [HALLWAY, ROOM_A, ROOM_B, ROOM_C, ROOM_D].flatten(1)
grid = Hash[*coords]

puts
