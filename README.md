# Endainness-Based-SV-Encryptor
SystemVerilog 64-bit serializer/encryptor featuring configurable byte and bit endianness modes (Big/Little Endian) to convert parallel input data into a 64-cycle serial stream.

# Sure_Encryptor

A SystemVerilog hardware module that performs configurable endianness transformations (byte-level and bit-level) on 64-bit parallel data and streams the reordered result out serially over 64 clock cycles.

---

## Architecture & Operation

The core uses a 2-bit control signal (`mode`) to dynamically reorder 64-bit input data (`din`) before shifting it out bit-by-bit via `serial_out` MSB-first.

### Endianness Mapping Modes

| `mode[1:0]` | Byte Endianness (`mode[1]`) | Bit Endianness (`mode[0]`) | Description |
| :---: | :--- | :--- | :--- |
| **`00`** | Big-Endian | Big-Endian | Direct passthrough order. |
| **`01`** | Big-Endian | Little-Endian | Reverses bit order within each byte. |
| **`10`** | Little-Endian | Big-Endian | Reverses byte order across the 64-bit word. |
| **`11`** | Little-Endian | Little-Endian | Full bit-reversal and byte-reversal (2-bit little-endian equivalent). |

---

## Hardware Interface

| Signal | Direction | Width | Description |
| :--- | :---: | :---: | :--- |
| `clk` | Input | 1 | System clock |
| `rst` | Input | 1 | Active-high synchronous reset |
| `start` | Input | 1 | Triggers latching and serial transmission |
| `mode` | Input | 2 | Endianness configuration mode |
| `din` | Input | 64 | Parallel input data bus |
| `serial_out` | Output | 1 | MSB-first serial output stream |
| `busy` | Output | 1 | Asserted during the 64-cycle transmission |

---

## Simulation & Verification

### EDA Playground Link
https://edaplayground.com/x/wsDk

