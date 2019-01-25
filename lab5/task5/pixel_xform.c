/* NOTE: this file must be self-contained */

/*
 *  Transforms the pixel (x_in,y_in) using the matrix specified by m.
 *
 *  Pixel coordinates are integers, but the entries of m are Q16 fixed-point numbers.
 *
 *  If the matrix M is defined like this:
 *  
 *      M00 M01 M02
 *      M10 M11 M12
 *      M20 M21 M22
 *
 *  then m[0] is M00, m[1] is M01, m[4] is M10, and so on. The computation is
 *
 *      x_out       M00 M01 M02       x_in
 *      y_out   =   M10 M11 M12   x   y_in
 *      ?           M20 M21 M22       1
 *
 *  and the output pixel will be (*x_out,*y_out).
 */
void pixel_xform(unsigned x_in, unsigned y_in,
                        unsigned *x_out, unsigned *y_out,
                        int *m);



inline void pixel_xform(unsigned x_in, unsigned y_in,
                        unsigned *x_out, unsigned *y_out,
                        int *m) {
    /* your code here */

    int x_out1, y_out1;
	(*x_out) = hw_mult(x_in, m[0]) + hw_mult(y_in, m[1]) + m[2];
	(*y_out) = hw_mult(x_in, m[3]) + hw_mult(y_in, m[4]) + m[5];
    (*x_out) = (*x_out) >> 16;
	(*y_out) = (*y_out) >> 16;
}