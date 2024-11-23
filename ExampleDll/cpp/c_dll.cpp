#include <windows.h>
#include <iostream>
#include <cstdint> // Để sử dụng int32_t

// Dùng __declspec(dllexport) để xuất khẩu các hàm
extern "C"
{
    __declspec(dllexport) void hello_world_from_c()
    {
        std::cout << "Hello from C++ DLL!" << std::endl;
    }
}