module main

#flag -I"./include" // include header file
#flag -L"."
#flag -l"c_dll"
#flag -l"lua54"

#include "lua.h"
#include "lauxlib.h"
#include "lualib.h"

#flag -gcc
#flag -g
#flag -Wall

struct C.lua_State {}

fn C.luaL_newstate() &C.lua_State
fn C.luaL_openlibs(&C.lua_State)
fn C.lua_close(&C.lua_State)

fn C.luaL_dostring(&C.lua_State, &char) int

fn print_hello_from_lua() {
	println('Bắt đầu gọi lua')
	lstate := C.luaL_newstate()
	println('lstate: ${lstate}')

	C.luaL_openlibs(lstate) // Open standard Lua libraries

	C.luaL_dostring(lstate, c"print('Hello from lua')")

	C.lua_close(lstate)
	println('Done gọi lua ?')
}

fn C.printAge(int)

fn main() {
	println('Start')
	C.printAge(123)

	print_hello_from_lua()
}
