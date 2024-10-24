module main

import os

fn main() {
	println('Hello World!')

	println(os.args)

	a, b := buoi()

	println('a: ${a}, b: ${b}')
}

fn buoi() (int, int) {
	return 10, 20
}
