module main

import vom { is_hex_digit, tag, take_while_m_n, tuple }

struct Color {
	red   byte
	green byte
	blue  byte
}

fn from_hex(input string) byte {
	return '0x${input}'.u8()
}

fn hex_primary(input string) !(string, string) {
	parser := take_while_m_n(2, 2, is_hex_digit)
	return parser(input)
}

fn hex_color(input string) !(string, Color) {
	discard := tag('#')
	hex_part, _ := discard(input)!
	parser := tuple([hex_primary, hex_primary, hex_primary])
	rest, output := parser(hex_part)!
	red, green, blue := from_hex(output[0]), from_hex(output[1]), from_hex(output[2])
	return rest, Color{red, green, blue}
}

fn main() {
	_, color := hex_color('#2F14DF')!
	assert color == Color{47, 20, 223}
	println(color)
}
