import time
import serial

print("BEGIN RECEIVE DATA")


serial_port = serial.Serial(
    port="COM8",                #记得替换此处端口号
    baudrate=12800,
    bytesize=serial.EIGHTBITS,
    parity=serial.PARITY_NONE,
    stopbits=serial.STOPBITS_ONE,
)
# Wait a second to let the port initialize
time.sleep(1)

try:
    # Send a simple header
    serial_port.write("UART Demonstration Program\r\n".encode())
    serial_port.write("NVIDIA Jetson Nano Developer Kit\r\n".encode())
    def data1():
        data=None
        while data is None:
            if serial_port.inWaiting() > 0:
                data = serial_port.read()
        return ord(data)
    print(f'this is the {data1()}-th case')
    print(f'入栈的参数{data1()}')
    while True:
        a=data1()
        print(f'当前参数{a}')
        if a == 0:
            print(f'入栈完毕')
            break
    # while True:
    #     if serial_port.inWaiting() > 0:
    #         data = serial_port.read()
    #         print(ord(data))



except KeyboardInterrupt:
    print("Exiting Program")

except Exception as exception_error:
    print("Error occurred. Exiting Program")
    print("Error: " + str(exception_error))

finally:
    serial_port.close()
    pass
