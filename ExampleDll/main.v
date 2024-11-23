module main

import dl.loader

type DLLFunc = fn ()

fn main() {
	mut dl_loader := loader.get_or_create_dynamic_lib_loader(
		key:   'example'
		paths: ['./example.dll']
	) or {
		println('Error loading DLL: ${err}')
		return
	}

	defer {
		dl_loader.unregister()
	}

	dll_func := dl_loader.get_sym('name_pulbliczz') or {
		println('ERROR load function: ${err}')
		return
	}

	f_hello_world := DLLFunc(dll_func)

	f_hello_world()
}
