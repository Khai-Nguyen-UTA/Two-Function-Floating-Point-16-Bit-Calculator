module MantissaNormalizerBitShifter (in, ctrl, shifted);

    input [10:0] in;        // 11-bit input
    input [4:0] ctrl;       // Control signal for up to 16 shifts
    output [10:0] shifted;  // 11-bit output
    wire [10:0] x, y, z, w;

    // Shift ctrl[4] (Shift by 16 or clear all)
    BSMux BSMux40 (in[10], (1'b0), ctrl[4], w[10]);
    BSMux BSMux41 (in[9],  (1'b0), ctrl[4], w[9]);
    BSMux BSMux42 (in[8],  (1'b0), ctrl[4], w[8]);
    BSMux BSMux43 (in[7],  (1'b0), ctrl[4], w[7]);
    BSMux BSMux44 (in[6],  (1'b0), ctrl[4], w[6]);
    BSMux BSMux45 (in[5],  (1'b0), ctrl[4], w[5]);
    BSMux BSMux46 (in[4],  (1'b0), ctrl[4], w[4]);
    BSMux BSMux47 (in[3],  (1'b0), ctrl[4], w[3]);
    BSMux BSMux48 (in[2],  (1'b0), ctrl[4], w[2]);
    BSMux BSMux49 (in[1],  (1'b0), ctrl[4], w[1]);
    BSMux BSMux410(in[0],  (1'b0), ctrl[4], w[0]);

    // Shift ctrl[3]
    BSMux BSMux30 (w[10], (1'b0), ctrl[3], z[10]);
    BSMux BSMux31 (w[9],  (1'b0), ctrl[3], z[9]);
    BSMux BSMux32 (w[8],  (1'b0), ctrl[3], z[8]);
    BSMux BSMux33 (w[7],  (1'b0), ctrl[3], z[7]);
    BSMux BSMux34 (w[6],  (1'b0), ctrl[3], z[6]);
    BSMux BSMux35 (w[5],  (1'b0), ctrl[3], z[5]);
    BSMux BSMux36 (w[4],  (w[10]), ctrl[3], z[4]);
    BSMux BSMux37 (w[3],  (w[9]),  ctrl[3], z[3]);
    BSMux BSMux38 (w[2],  (w[8]),  ctrl[3], z[2]);
    BSMux BSMux39 (w[1],  (w[7]),  ctrl[3], z[1]);
    BSMux BSMux310(w[0],  (w[6]),  ctrl[3], z[0]);

    // Shift ctrl[2]
    BSMux BSMux20 (z[10], (1'b0), ctrl[2], x[10]);
    BSMux BSMux21 (z[9],  (1'b0), ctrl[2], x[9]);
    BSMux BSMux22 (z[8],  (1'b0), ctrl[2], x[8]);
    BSMux BSMux23 (z[7],  (z[10]), ctrl[2], x[7]);
    BSMux BSMux24 (z[6],  (z[9]),  ctrl[2], x[6]);
    BSMux BSMux25 (z[5],  (z[8]),  ctrl[2], x[5]);
    BSMux BSMux26 (z[4],  (z[7]),  ctrl[2], x[4]);
    BSMux BSMux27 (z[3],  (z[6]),  ctrl[2], x[3]);
    BSMux BSMux28 (z[2],  (z[5]),  ctrl[2], x[2]);
    BSMux BSMux29 (z[1],  (z[4]),  ctrl[2], x[1]);
    BSMux BSMux210(z[0],  (z[3]),  ctrl[2], x[0]);

    // Shift ctrl[1]
    BSMux BSMux10 (x[10], (1'b0), ctrl[1], y[10]);
    BSMux BSMux11 (x[9],  (1'b0), ctrl[1], y[9]);
    BSMux BSMux12 (x[8],  (x[10]), ctrl[1], y[8]);
    BSMux BSMux13 (x[7],  (x[9]),  ctrl[1], y[7]);
    BSMux BSMux14 (x[6],  (x[8]),  ctrl[1], y[6]);
    BSMux BSMux15 (x[5],  (x[7]),  ctrl[1], y[5]);
    BSMux BSMux16 (x[4],  (x[6]),  ctrl[1], y[4]);
    BSMux BSMux17 (x[3],  (x[5]),  ctrl[1], y[3]);
    BSMux BSMux18 (x[2],  (x[4]),  ctrl[1], y[2]);
    BSMux BSMux19 (x[1],  (x[3]),  ctrl[1], y[1]);
    BSMux BSMux110(x[0],  (x[2]),  ctrl[1], y[0]);

    // Shift ctrl[0]
    BSMux BSMux00 (y[10], (1'b0), ctrl[0], shifted[10]);
    BSMux BSMux01 (y[9],  (y[10]), ctrl[0], shifted[9]);
    BSMux BSMux02 (y[8],  (y[9]),  ctrl[0], shifted[8]);
    BSMux BSMux03 (y[7],  (y[8]),  ctrl[0], shifted[7]);
    BSMux BSMux04 (y[6],  (y[7]),  ctrl[0], shifted[6]);
    BSMux BSMux05 (y[5],  (y[6]),  ctrl[0], shifted[5]);
    BSMux BSMux06 (y[4],  (y[5]),  ctrl[0], shifted[4]);
    BSMux BSMux07 (y[3],  (y[4]),  ctrl[0], shifted[3]);
    BSMux BSMux08 (y[2],  (y[3]),  ctrl[0], shifted[2]);
    BSMux BSMux09 (y[1],  (y[2]),  ctrl[0], shifted[1]);
    BSMux BSMux010(y[0],  (y[1]),  ctrl[0], shifted[0]);

endmodule
