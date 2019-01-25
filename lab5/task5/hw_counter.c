/* NOTE: this file must be self-contained */
unsigned long long hw_counter();

#define LOW_WORD    (volatile unsigned long *)0x000a100
#define HIGH_WORD   (volatile unsigned long *)0x000a104
#define count       (volatile unsigned long long *)0x0007500 

inline unsigned long long hw_counter() {

	unsigned long low;
	low = *LOW_WORD;

	unsigned long long high;
	high = *HIGH_WORD;

	if (*HIGH_WORD == high) {
		(*count) = (high << 32) | low;
	}
	else {
		(*count) = (high << 32) | 0xffffffff;
	}

	return (*count);
}