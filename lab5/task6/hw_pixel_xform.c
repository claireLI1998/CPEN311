/* NOTE: this file must be self-contained */

/*
 *  set_xform() sets the transformation matrix in your accelerator,
 *  and vga_plot_xformed() sends a pixel to your accelerator to be transformed.
 *
 *  Pixel coordinates are integers, but the entries of m are Q16 fixed-point numbers.
 *
 *  If the matrix M is defined like this:
 *  
 *      M00 M01 M02
 *      M10 M11 M12
 *      M20 M21 M22
 *
 *  then m[0] is M00, m[1] is M01, m[4] is M10, and so on.
 */

inline void set_xform(int *m) {
    /* your code here */
}

inline void vga_plot_xformed(unsigned x_in, unsigned y_in, unsigned colour) {
    /* your code here */
}
