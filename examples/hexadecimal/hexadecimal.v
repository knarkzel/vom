module main

import vom { is_hex_digit, tag, take_while_m_n, tuple }

struct Color {
	red   u8
	green u8
	blue  u8
}

fn from_hex(input string) u8 {
	return '0x${input}'.u8()
}

fn hex_primary(input string) !(string, string, int) {
	parser := take_while_m_n(2, 2, is_hex_digit)
	return parser(input)
}

fn hex_color(input string) !(string, Color) {
	discard := tag('#')
	hex_part, _, _ := discard(input)!
	parser := tuple([hex_primary, hex_primary, hex_primary])
	rest, output, _ := parser(hex_part)!
	red, green, blue := from_hex(output[0]), from_hex(output[1]), from_hex(output[2])
	return rest, Color{red, green, blue}
}

fn main() {
	_, color := hex_color('#2F14DF')!
	assert color == Color{47, 20, 223}
	println(color)
}
