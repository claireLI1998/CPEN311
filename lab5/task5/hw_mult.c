int hw_mult(int x, int y);

#define MULT_N 0x00

#define RESULT (volatile unsigned long *) 0x7160

#define MULT(x,y) __builtin_custom_inii(MULT_N, (x), (y));

inline int hw_mult(int x, int y) {
	/* your code using the custom instruction here */
	return MULT(x, y);
}