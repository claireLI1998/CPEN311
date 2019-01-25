/* NOTE: this file must be self-contained */
													
													
#define VGA_ADDR (volatile unsigned long *) 0x000a200

extern inline void vga_plot(unsigned, unsigned, unsigned);
inline void vga_plot(unsigned x, unsigned y, unsigned colour){
	(*VGA_ADDR) = (colour << 16) + (x << 8) + y;
}


