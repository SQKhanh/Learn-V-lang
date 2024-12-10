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

    __declspec(dllexport) void hello_world_from_cButCamelCase()
    {
        std::cout << "Hello from C++ DLL! but camelCase" << std::endl;
    }

    __declspec(dllexport) void printAge(int age)
    {
        std::cout << "Hello from C++ DLL! age: " << age << std::endl;
    }
}