module main

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

fn print_hello_from_lua() {
	println('Bắt đầu gọi lua')
	lstate := C.luaL_newstate()

	C.luaL_openlibs(lstate) // Open standard Lua libraries

	C.luaL_dostring(lstate, c"print('Hello from lua')")

	C.lua_close(lstate)
	println('Done gọi lua ?')
}

fn main() {
	println('Start')

	print_hello_from_lua()
}
