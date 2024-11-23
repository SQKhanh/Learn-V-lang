module main

import dl.loader

type DLLFunc = fn ()

fn call_v_dll() {
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

	dll_func := dl_loader.get_sym('name_pulblic') or {
		println('ERROR load function name_pulblic: ${err}')
		return
	}

	f_hello_world := DLLFunc(dll_func)

	f_hello_world()
}

fn call_c_dll() {
	mut dl_loader := loader.get_or_create_dynamic_lib_loader(
		key:   'example'
		paths: ['./c_dll.dll']
	) or {
		println('Error loading DLL: ${err}')
		return
	}

	defer {
		dl_loader.unregister()
	}

	dll_func := dl_loader.get_sym('hello_world_from_c') or {
		println('ERROR load function hello_world_from_c: ${err}')
		return
	}

	f_hello_world := DLLFunc(dll_func)

	f_hello_world()
}

fn main() {
	call_v_dll()
	call_c_dll()
}
