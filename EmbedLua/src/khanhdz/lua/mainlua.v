module lua

#flag -I"./include" // include header file
#flag -L"."
#flag -l"lua54"

#include "lua.h"
#include "lauxlib.h"
#include "lualib.h"

struct C.lua_State {}

fn C.luaL_newstate() &C.lua_State
fn C.luaL_openlibs(&C.lua_State)
fn C.lua_close(&C.lua_State)

fn C.luaL_dostring(&C.lua_State, &char) int

fn C.luaL_dofile(&C.lua_State, &char) int

// Hàm để chạy file Lua
fn C.lua_tolstring(l &C.lua_State, idx int, len &usize) &char

pub fn print_hello_from_lua() {
	println('Bắt đầu gọi lua')
	lstate := C.luaL_newstate()

	C.luaL_openlibs(lstate) // Open standard Lua libraries
	C.luaL_dostring(lstate, c"print('Hello from lua')")

	// Chuyển đường dẫn file từ V sang C-string và chạy
	res := C.luaL_dofile(lstate, c'scripts/main.lua')

	if res != 0 {
		// Nếu có lỗi, in thông báo lỗi từ Lua
		error_msg := unsafe {
			cstring_to_vstring(C.lua_tolstring(lstate, -1, 0))
		}
		println('Lỗi khi chạy Lua: ${error_msg}')
	}

	C.lua_close(lstate)
	println('Done gọi lua ?')
}
