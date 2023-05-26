# CPU_proj_for_CS214

cpuclk 输出 ori_clk, cpu_clk, uart_clk;

clk_1k 输出的频率应该也许好像是1k(至少数量级一样)，反正能用，输入使用uart_clk

keypad_n

line：键盘输入端口 4

row：键盘输出端口 4

clk：uart_clk 1

o1：输出 4

pad_decode

in 输入，来自o1 4

o1-o8 输出，o1为最新位 4

