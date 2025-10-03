// kernel.c - main OS logic in C

#include <stddef.h>
#include <stdint.h>

#define VGA_MEMORY 0xB8000
#define VGA_WIDTH  80

static uint16_t* const vga_buffer = (uint16_t*)VGA_MEMORY;
static size_t row = 0, col = 0;

static inline uint16_t vga_entry(char c, uint8_t color) {
    return (uint16_t)c | (uint16_t)color << 8;
}

void putchar(char c) {
    if (c == '\n') {
        col = 0;
        row++;
        return;
    }
    vga_buffer[row * VGA_WIDTH + col] = vga_entry(c, 0x0A); // light green
    col++;
}

void print(const char* str) {
    for (size_t i = 0; str[i]; i++) {
        putchar(str[i]);
    }
}

void kernel_main(void) {
    print("Hello, OS!\n");
    print("Welcome to shrekOS\n");
}
