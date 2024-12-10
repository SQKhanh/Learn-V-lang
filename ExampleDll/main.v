module main

import dl.loader

#include <stdio.h>

type DLLFunc = fn ()
type DLLFunc_Int = fn (int)

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

	dll_func2 := dl_loader.get_sym('hello_world_from_cButCamelCase') or {
		println('ERROR load function hello_world_from_cButCamelCase: ${err}')
		return
	}

	f_hello_world2 := DLLFunc(dll_func2)

	f_hello_world2()


	dll_func3 := dl_loader.get_sym('printAge') or {
		println('ERROR load function printAge: ${err}')
		return
	}

	f_hello_world3 := DLLFunc_Int(dll_func3)

	f_hello_world3(18)
}

fn main() {
	call_v_dll()
	call_c_dll()

	C.printf(c'ni hao maaaaa')
}
