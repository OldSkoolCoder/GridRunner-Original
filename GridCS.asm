

	// Character Number : 0 ($00) HexOffset : $0000 
	.byte %00011000			// ...xx...
	.byte %00011000			// ...xx...
	.byte %00011000			// ...xx...
	.byte %00011000			// ...xx...
	.byte %11111111			// xxxxxxxx
	.byte %00011000			// ...xx...
	.byte %00011000			// ...xx...
	.byte %00011000			// ...xx...


	// Character Number : 1 ($01) HexOffset : $0008 
	.byte %11110000			// xxxx....
	.byte %00100000			// ..x.....
	.byte %00010000			// ...x....
	.byte %00011111			// ...xxxxx
	.byte %00011111			// ...xxxxx
	.byte %00010000			// ...x....
	.byte %00100000			// ..x.....
	.byte %11110000			// xxxx....


	// Character Number : 2 ($02) HexOffset : $0010 
	.byte %00011000			// ...xx...
	.byte %00011000			// ...xx...
	.byte %00011000			// ...xx...
	.byte %00011000			// ...xx...
	.byte %10111101			// x.xxxx.x
	.byte %11000011			// xx....xx
	.byte %10000001			// x......x
	.byte %10000001			// x......x


	// Character Number : 3 ($03) HexOffset : $0018 
	.byte %00000000			// ........
	.byte %00100000			// ..x.....
	.byte %01100000			// .xx.....
	.byte %10100011			// x.x...xx
	.byte %00101100			// ..x.xx..
	.byte %00110000			// ..xx....
	.byte %00000000			// ........
	.byte %00000000			// ........


	// Character Number : 4 ($04) HexOffset : $0020 
	.byte %00000000			// ........
	.byte %00000010			// ......x.
	.byte %00000101			// .....x.x
	.byte %11001000			// xx..x...
	.byte %00110000			// ..xx....
	.byte %00000000			// ........
	.byte %00000000			// ........
	.byte %00000000			// ........


	// Character Number : 5 ($05) HexOffset : $0028 
	.byte %00001000			// ....x...
	.byte %00000100			// .....x..
	.byte %00111110			// ..xxxxx.
	.byte %00100000			// ..x.....
	.byte %00010000			// ...x....
	.byte %00010000			// ...x....
	.byte %00001000			// ....x...
	.byte %00001000			// ....x...


	// Character Number : 6 ($06) HexOffset : $0030 
	.byte %00001000			// ....x...
	.byte %00001000			// ....x...
	.byte %00010000			// ...x....
	.byte %00010000			// ...x....
	.byte %00001000			// ....x...
	.byte %00000100			// .....x..
	.byte %00000010			// ......x.
	.byte %00000100			// .....x..


	// Character Number : 7 ($07) HexOffset : $0038 
	.byte %00011000			// ...xx...
	.byte %00111100			// ..xxxx..
	.byte %01100110			// .xx..xx.
	.byte %00011000			// ...xx...
	.byte %01111110			// .xxxxxx.
	.byte %11111111			// xxxxxxxx
	.byte %11100111			// xxx..xxx
	.byte %11000011			// xx....xx


	// Character Number : 8 ($08) HexOffset : $0040 
	.byte %00011000			// ...xx...
	.byte %00011000			// ...xx...
	.byte %00011000			// ...xx...
	.byte %00111100			// ..xxxx..
	.byte %01111110			// .xxxxxx.
	.byte %01111110			// .xxxxxx.
	.byte %01111110			// .xxxxxx.
	.byte %00111100			// ..xxxx..


	// Character Number : 9 ($09) HexOffset : $0048 
	.byte %00111100			// ..xxxx..
	.byte %01111110			// .xxxxxx.
	.byte %01111110			// .xxxxxx.
	.byte %01111110			// .xxxxxx.
	.byte %00111100			// ..xxxx..
	.byte %00011000			// ...xx...
	.byte %00011000			// ...xx...
	.byte %00011000			// ...xx...


	// Character Number : 10 ($0a) HexOffset : $0050 
	.byte %01000010			// .x....x.
	.byte %01100110			// .xx..xx.
	.byte %00100100			// ..x..x..
	.byte %00111100			// ..xxxx..
	.byte %00011000			// ...xx...
	.byte %00011000			// ...xx...
	.byte %00111100			// ..xxxx..
	.byte %00011000			// ...xx...


	// Character Number : 11 ($0b) HexOffset : $0058 
	.byte %00000000			// ........
	.byte %11000000			// xx......
	.byte %01110010			// .xxx..x.
	.byte %00011111			// ...xxxxx
	.byte %00011111			// ...xxxxx
	.byte %01110010			// .xxx..x.
	.byte %11000000			// xx......
	.byte %00000000			// ........


	// Character Number : 12 ($0c) HexOffset : $0060 
	.byte %00000000			// ........
	.byte %00000011			// ......xx
	.byte %01001110			// .x..xxx.
	.byte %11111000			// xxxxx...
	.byte %11111000			// xxxxx...
	.byte %01001110			// .x..xxx.
	.byte %00000011			// ......xx
	.byte %00000000			// ........


	// Character Number : 13 ($0d) HexOffset : $0068 
	.byte %00000000			// ........
	.byte %00000000			// ........
	.byte %00000000			// ........
	.byte %00011000			// ...xx...
	.byte %00011000			// ...xx...
	.byte %00000000			// ........
	.byte %00000000			// ........
	.byte %00000000			// ........


	// Character Number : 14 ($0e) HexOffset : $0070 
	.byte %00000000			// ........
	.byte %00000000			// ........
	.byte %00011000			// ...xx...
	.byte %00111100			// ..xxxx..
	.byte %00111100			// ..xxxx..
	.byte %00011000			// ...xx...
	.byte %00000000			// ........
	.byte %00000000			// ........


	// Character Number : 15 ($0f) HexOffset : $0078 
	.byte %00011000			// ...xx...
	.byte %00100100			// ..x..x..
	.byte %01011010			// .x.xx.x.
	.byte %10111101			// x.xxxx.x
	.byte %10111101			// x.xxxx.x
	.byte %01011010			// .x.xx.x.
	.byte %00100100			// ..x..x..
	.byte %00011000			// ...xx...


	// Character Number : 16 ($10) HexOffset : $0080 
	.byte %10011001			// x..xx..x
	.byte %01111110			// .xxxxxx.
	.byte %01011010			// .x.xx.x.
	.byte %11111111			// xxxxxxxx
	.byte %11111111			// xxxxxxxx
	.byte %01011010			// .x.xx.x.
	.byte %01111110			// .xxxxxx.
	.byte %10011001			// x..xx..x


	// Character Number : 17 ($11) HexOffset : $0088 
	.byte %01100110			// .xx..xx.
	.byte %10011001			// x..xx..x
	.byte %10111101			// x.xxxx.x
	.byte %01011010			// .x.xx.x.
	.byte %01011010			// .x.xx.x.
	.byte %10111101			// x.xxxx.x
	.byte %10011001			// x..xx..x
	.byte %01100110			// .xx..xx.


	// Character Number : 18 ($12) HexOffset : $0090 
	.byte %00100100			// ..x..x..
	.byte %01000010			// .x....x.
	.byte %10100101			// x.x..x.x
	.byte %00000000			// ........
	.byte %00000000			// ........
	.byte %10100101			// x.x..x.x
	.byte %01000010			// .x....x.
	.byte %00100100			// ..x..x..


	// Character Number : 19 ($13) HexOffset : $0098 
	.byte %00110000			// ..xx....
	.byte %01000110			// .x...xx.
	.byte %01001000			// .x..x...
	.byte %11111111			// xxxxxxxx
	.byte %11111111			// xxxxxxxx
	.byte %00010010			// ...x..x.
	.byte %01100010			// .xx...x.
	.byte %00001100			// ....xx..


	// Character Number : 20 ($14) HexOffset : $00a0 
	.byte %11000000			// xx......
	.byte %11111100			// xxxxxx..
	.byte %01110010			// .xxx..x.
	.byte %11111000			// xxxxx...
	.byte %00011111			// ...xxxxx
	.byte %01001110			// .x..xxx.
	.byte %00111111			// ..xxxxxx
	.byte %00000011			// ......xx


	// Character Number : 21 ($15) HexOffset : $00a8 
	.byte %00001011			// ....x.xx
	.byte %00101111			// ..x.xxxx
	.byte %01001110			// .x..xxx.
	.byte %01011110			// .x.xxxx.
	.byte %01111010			// .xxxx.x.
	.byte %01110010			// .xxx..x.
	.byte %11110100			// xxxx.x..
	.byte %11010000			// xx.x....


	// Character Number : 22 ($16) HexOffset : $00b0 
	.byte %00000000			// ........
	.byte %01000110			// .x...xx.
	.byte %00101000			// ..x.x...
	.byte %10000000			// x.......
	.byte %00010110			// ...x.xx.
	.byte %00001000			// ....x...
	.byte %00100000			// ..x.....
	.byte %01000010			// .x....x.


	// Character Number : 23 ($17) HexOffset : $00b8 
	.byte %01000000			// .x......
	.byte %00100001			// ..x....x
	.byte %00000110			// .....xx.
	.byte %00000000			// ........
	.byte %00000000			// ........
	.byte %01100000			// .xx.....
	.byte %10000010			// x.....x.
	.byte %00000001			// .......x


	// Character Number : 24 ($18) HexOffset : $00c0 
	.byte %00000010			// ......x.
	.byte %10000000			// x.......
	.byte %00000000			// ........
	.byte %00000000			// ........
	.byte %00000000			// ........
	.byte %00000000			// ........
	.byte %00000001			// .......x
	.byte %01000000			// .x......


	// Character Number : 25 ($19) HexOffset : $00c8 
	.byte %00000000			// ........
	.byte %11110011			// xxxx..xx
	.byte %11011011			// xx.xx.xx
	.byte %11110011			// xxxx..xx
	.byte %11000011			// xx....xx
	.byte %11000011			// xx....xx
	.byte %00000000			// ........
	.byte %00000000			// ........


	// Character Number : 26 ($1a) HexOffset : $00d0 
	.byte %00000000			// ........
	.byte %00000011			// ......xx
	.byte %00000011			// ......xx
	.byte %00000011			// ......xx
	.byte %00000011			// ......xx
	.byte %11011011			// xx.xx.xx
	.byte %00000000			// ........
	.byte %00000000			// ........


	// Character Number : 27 ($1b) HexOffset : $00d8 
	.byte %11000110			// xx...xx.
	.byte %11000110			// xx...xx.
	.byte %00000000			// ........
	.byte %01111100			// .xxxxx..
	.byte %00111000			// ..xxx...
	.byte %00111000			// ..xxx...
	.byte %00111000			// ..xxx...
	.byte %00111000			// ..xxx...


	// Character Number : 28 ($1c) HexOffset : $00e0 
	.byte %11000110			// xx...xx.
	.byte %11000110			// xx...xx.
	.byte %00000000			// ........
	.byte %01111100			// .xxxxx..
	.byte %00111000			// ..xxx...
	.byte %00111000			// ..xxx...
	.byte %00111000			// ..xxx...
	.byte %00111000			// ..xxx...


	// Character Number : 29 ($1d) HexOffset : $00e8 
	.byte %00000000			// ........
	.byte %11001100			// xx..xx..
	.byte %11001100			// xx..xx..
	.byte %11111100			// xxxxxx..
	.byte %11001100			// xx..xx..
	.byte %11001100			// xx..xx..
	.byte %00000000			// ........
	.byte %00000000			// ........


	// Character Number : 30 ($1e) HexOffset : $00f0 
	.byte %00000000			// ........
	.byte %11110000			// xxxx....
	.byte %01100110			// .xx..xx.
	.byte %01100000			// .xx.....
	.byte %01100110			// .xx..xx.
	.byte %11110000			// xxxx....
	.byte %00000000			// ........
	.byte %00000000			// ........


	// Character Number : 31 ($1f) HexOffset : $00f8 
	.byte %00000000			// ........
	.byte %00010000			// ...x....
	.byte %00001000			// ....x...
	.byte %01111100			// .xxxxx..
	.byte %00001000			// ....x...
	.byte %00010000			// ...x....
	.byte %00000000			// ........
	.byte %00000000			// ........


	// Character Number : 32 ($20) HexOffset : $0100 
	.byte %00000000			// ........
	.byte %00000000			// ........
	.byte %00000000			// ........
	.byte %00000000			// ........
	.byte %00000000			// ........
	.byte %00000000			// ........
	.byte %00000000			// ........
	.byte %00000000			// ........


	// Character Number : 33 ($21) HexOffset : $0108 
	.byte %01111100			// .xxxxx..
	.byte %11111110			// xxxxxxx.
	.byte %00000000			// ........
	.byte %11000000			// xx......
	.byte %11011110			// xx.xxxx.
	.byte %11000110			// xx...xx.
	.byte %11000110			// xx...xx.
	.byte %01111100			// .xxxxx..


	// Character Number : 34 ($22) HexOffset : $0110 
	.byte %11111100			// xxxxxx..
	.byte %11111110			// xxxxxxx.
	.byte %00000000			// ........
	.byte %11000110			// xx...xx.
	.byte %11111100			// xxxxxx..
	.byte %11010000			// xx.x....
	.byte %11001000			// xx..x...
	.byte %11000110			// xx...xx.


	// Character Number : 35 ($23) HexOffset : $0118 
	.byte %11000110			// xx...xx.
	.byte %11000110			// xx...xx.
	.byte %00000000			// ........
	.byte %11000110			// xx...xx.
	.byte %11000110			// xx...xx.
	.byte %11000110			// xx...xx.
	.byte %11111110			// xxxxxxx.
	.byte %01111100			// .xxxxx..


	// Character Number : 36 ($24) HexOffset : $0120 
	.byte %11111100			// xxxxxx..
	.byte %11111100			// xxxxxx..
	.byte %00000000			// ........
	.byte %00110000			// ..xx....
	.byte %00110000			// ..xx....
	.byte %00110000			// ..xx....
	.byte %11111100			// xxxxxx..
	.byte %11111100			// xxxxxx..


	// Character Number : 37 ($25) HexOffset : $0128 
	.byte %11111100			// xxxxxx..
	.byte %11111110			// xxxxxxx.
	.byte %00000000			// ........
	.byte %11000110			// xx...xx.
	.byte %11000110			// xx...xx.
	.byte %11000110			// xx...xx.
	.byte %11111110			// xxxxxxx.
	.byte %11111100			// xxxxxx..


	// Character Number : 38 ($26) HexOffset : $0130 
	.byte %11000110			// xx...xx.
	.byte %11000110			// xx...xx.
	.byte %00000000			// ........
	.byte %11100110			// xxx..xx.
	.byte %11110110			// xxxx.xx.
	.byte %11011110			// xx.xxxx.
	.byte %11001110			// xx..xxx.
	.byte %11000110			// xx...xx.


	// Character Number : 39 ($27) HexOffset : $0138 
	.byte %11111110			// xxxxxxx.
	.byte %11111110			// xxxxxxx.
	.byte %00000000			// ........
	.byte %11110000			// xxxx....
	.byte %11110000			// xxxx....
	.byte %11000000			// xx......
	.byte %11111110			// xxxxxxx.
	.byte %11111110			// xxxxxxx.


	// Character Number : 40 ($28) HexOffset : $0140 
	.byte %11111110			// xxxxxxx.
	.byte %11111110			// xxxxxxx.
	.byte %00000000			// ........
	.byte %11000110			// xx...xx.
	.byte %11111110			// xxxxxxx.
	.byte %11000110			// xx...xx.
	.byte %11000110			// xx...xx.
	.byte %11000110			// xx...xx.


	// Character Number : 41 ($29) HexOffset : $0148 
	.byte %11111100			// xxxxxx..
	.byte %11111110			// xxxxxxx.
	.byte %00000000			// ........
	.byte %11000110			// xx...xx.
	.byte %11111100			// xxxxxx..
	.byte %11000110			// xx...xx.
	.byte %11000110			// xx...xx.
	.byte %11111100			// xxxxxx..


	// Character Number : 42 ($2a) HexOffset : $0150 
	.byte %11111110			// xxxxxxx.
	.byte %11111110			// xxxxxxx.
	.byte %00000000			// ........
	.byte %11110000			// xxxx....
	.byte %11110000			// xxxx....
	.byte %11000000			// xx......
	.byte %11000000			// xx......
	.byte %11000000			// xx......


	// Character Number : 43 ($2b) HexOffset : $0158 
	.byte %11000110			// xx...xx.
	.byte %11000110			// xx...xx.
	.byte %00000000			// ........
	.byte %11000110			// xx...xx.
	.byte %11111110			// xxxxxxx.
	.byte %11000110			// xx...xx.
	.byte %11000110			// xx...xx.
	.byte %11000110			// xx...xx.


	// Character Number : 44 ($2c) HexOffset : $0160 
	.byte %00000110			// .....xx.
	.byte %00000110			// .....xx.
	.byte %00000000			// ........
	.byte %00000110			// .....xx.
	.byte %00000110			// .....xx.
	.byte %11000110			// xx...xx.
	.byte %11111110			// xxxxxxx.
	.byte %01111100			// .xxxxx..


	// Character Number : 45 ($2d) HexOffset : $0168 
	.byte %11000110			// xx...xx.
	.byte %11101110			// xxx.xxx.
	.byte %00000000			// ........
	.byte %11111110			// xxxxxxx.
	.byte %11000110			// xx...xx.
	.byte %11000110			// xx...xx.
	.byte %11000110			// xx...xx.
	.byte %11000110			// xx...xx.


	// Character Number : 46 ($2e) HexOffset : $0170 
	.byte %11111110			// xxxxxxx.
	.byte %11111110			// xxxxxxx.
	.byte %00000000			// ........
	.byte %11000110			// xx...xx.
	.byte %11111110			// xxxxxxx.
	.byte %11000000			// xx......
	.byte %11000000			// xx......
	.byte %11000000			// xx......


	// Character Number : 47 ($2f) HexOffset : $0178 
	.byte %11111110			// xxxxxxx.
	.byte %11111110			// xxxxxxx.
	.byte %00000000			// ........
	.byte %11000000			// xx......
	.byte %11111110			// xxxxxxx.
	.byte %00000110			// .....xx.
	.byte %11000110			// xx...xx.
	.byte %11111110			// xxxxxxx.


	// Character Number : 48 ($30) HexOffset : $0180 
	.byte %11111110			// xxxxxxx.
	.byte %11111110			// xxxxxxx.
	.byte %00000000			// ........
	.byte %11000110			// xx...xx.
	.byte %11000110			// xx...xx.
	.byte %11000110			// xx...xx.
	.byte %11111110			// xxxxxxx.
	.byte %11111110			// xxxxxxx.


	// Character Number : 49 ($31) HexOffset : $0188 
	.byte %00011000			// ...xx...
	.byte %00011000			// ...xx...
	.byte %00000000			// ........
	.byte %00011000			// ...xx...
	.byte %00111000			// ..xxx...
	.byte %00111000			// ..xxx...
	.byte %00111000			// ..xxx...
	.byte %00111000			// ..xxx...


	// Character Number : 50 ($32) HexOffset : $0190 
	.byte %01111100			// .xxxxx..
	.byte %11111110			// xxxxxxx.
	.byte %00000000			// ........
	.byte %00000110			// .....xx.
	.byte %00001100			// ....xx..
	.byte %00111000			// ..xxx...
	.byte %11111110			// xxxxxxx.
	.byte %11111110			// xxxxxxx.


	// Character Number : 51 ($33) HexOffset : $0198 
	.byte %01111100			// .xxxxx..
	.byte %11111110			// xxxxxxx.
	.byte %00000000			// ........
	.byte %00011110			// ...xxxx.
	.byte %00011110			// ...xxxx.
	.byte %00000110			// .....xx.
	.byte %11111110			// xxxxxxx.
	.byte %01111100			// .xxxxx..


	// Character Number : 52 ($34) HexOffset : $01a0 
	.byte %01100000			// .xx.....
	.byte %01100000			// .xx.....
	.byte %00000000			// ........
	.byte %11101100			// xxx.xx..
	.byte %11111110			// xxxxxxx.
	.byte %00001100			// ....xx..
	.byte %00001100			// ....xx..
	.byte %00001100			// ....xx..


	// Character Number : 53 ($35) HexOffset : $01a8 
	.byte %11111110			// xxxxxxx.
	.byte %11111110			// xxxxxxx.
	.byte %00000000			// ........
	.byte %11100000			// xxx.....
	.byte %01111100			// .xxxxx..
	.byte %00000110			// .....xx.
	.byte %11111110			// xxxxxxx.
	.byte %01111100			// .xxxxx..


	// Character Number : 54 ($36) HexOffset : $01b0 
	.byte %01111100			// .xxxxx..
	.byte %11111110			// xxxxxxx.
	.byte %00000000			// ........
	.byte %11000000			// xx......
	.byte %11111100			// xxxxxx..
	.byte %11000110			// xx...xx.
	.byte %11000110			// xx...xx.
	.byte %01111100			// .xxxxx..


	// Character Number : 55 ($37) HexOffset : $01b8 
	.byte %11111110			// xxxxxxx.
	.byte %11111110			// xxxxxxx.
	.byte %00000000			// ........
	.byte %00001100			// ....xx..
	.byte %00011000			// ...xx...
	.byte %00110000			// ..xx....
	.byte %00110000			// ..xx....
	.byte %01110000			// .xxx....


	// Character Number : 56 ($38) HexOffset : $01c0 
	.byte %01111100			// .xxxxx..
	.byte %11111110			// xxxxxxx.
	.byte %00000000			// ........
	.byte %11000110			// xx...xx.
	.byte %01111100			// .xxxxx..
	.byte %11000110			// xx...xx.
	.byte %11000110			// xx...xx.
	.byte %01111100			// .xxxxx..


	// Character Number : 57 ($39) HexOffset : $01c8 
	.byte %01111100			// .xxxxx..
	.byte %11111110			// xxxxxxx.
	.byte %00000000			// ........
	.byte %11000110			// xx...xx.
	.byte %01111110			// .xxxxxx.
	.byte %00000110			// .....xx.
	.byte %11111110			// xxxxxxx.
	.byte %01111100			// .xxxxx..


	// Character Number : 58 ($3a) HexOffset : $01d0 
	.byte %11111100			// xxxxxx..
	.byte %11111100			// xxxxxx..
	.byte %00000000			// ........
	.byte %00110000			// ..xx....
	.byte %00110000			// ..xx....
	.byte %00110000			// ..xx....
	.byte %00110000			// ..xx....
	.byte %00110000			// ..xx....


	// Character Number : 59 ($3b) HexOffset : $01d8 
	.byte %11000110			// xx...xx.
	.byte %11000110			// xx...xx.
	.byte %00000000			// ........
	.byte %11000110			// xx...xx.
	.byte %01101100			// .xx.xx..
	.byte %01101100			// .xx.xx..
	.byte %00111000			// ..xxx...
	.byte %00111000			// ..xxx...


	// Character Number : 60 ($3c) HexOffset : $01e0 
	.byte %00011111			// ...xxxxx
	.byte %00110000			// ..xx....
	.byte %01100111			// .xx..xxx
	.byte %11001100			// xx..xx..
	.byte %11001100			// xx..xx..
	.byte %01100111			// .xx..xxx
	.byte %00110000			// ..xx....
	.byte %00011111			// ...xxxxx


	// Character Number : 61 ($3d) HexOffset : $01e8 
	.byte %10000000			// x.......
	.byte %11000000			// xx......
	.byte %01100000			// .xx.....
	.byte %00110000			// ..xx....
	.byte %00110000			// ..xx....
	.byte %01100000			// .xx.....
	.byte %11000000			// xx......
	.byte %10000000			// x.......


	// Character Number : 62 ($3e) HexOffset : $01f0 
	.byte %11000000			// xx......
	.byte %11000000			// xx......
	.byte %00000000			// ........
	.byte %11000000			// xx......
	.byte %11000000			// xx......
	.byte %11000000			// xx......
	.byte %11111110			// xxxxxxx.
	.byte %11111110			// xxxxxxx.


	// Character Number : 63 ($3f) HexOffset : $01f8 
	.byte %00011000			// ...xx...
	.byte %00011000			// ...xx...
	.byte %00011000			// ...xx...
	.byte %00011000			// ...xx...
	.byte %00011000			// ...xx...
	.byte %00011000			// ...xx...
	.byte %00011000			// ...xx...
	.byte %00011000			// ...xx...


	// Character Number : 64 ($40) HexOffset : $0200 
	.byte %00000000			// ........