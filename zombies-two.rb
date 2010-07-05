=begin
zombies-two.rb -- Main file.

Zombies! 2 is released under the MIT license (see the LICENSE file for the full
text)
=end

[ 'lib/zombies', 'lib/creature', 'lib/human', 'lib/items', 'lib/map', 'lib/map-parser', 'lib/ai', 'lib/zombie' ].each { |file|
	require file
}
