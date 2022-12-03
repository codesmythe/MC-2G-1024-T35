This is a basic port of the Retrobrew
[MC-2G-1024](https://www.retrobrewcomputers.org/doku.php?id=builderpages:rhkoolstar:mc-2g-1024)
system to the S100computers.com
[FPGA_Z80_SBC](http://www.s100computers.com/My%20System%20Pages/FPGA%20Z80%20SBC/FPGA%20Z80%20SBC.htm)
board that uses Jeff Wilson's [Efinix T35 FPGA
Module](https://github.com/s100projects/T35_FPGA_MODULE) as its FPGA
base.

## System Hardware Components

  * Z80 CPU running at 25 MHz in the FPGA.
  
  * 128K SRAM using the block RAM in the FPGA.
  
  * UART using the Sparkfun USB-to-serial adapter of the S100 FPGA Z80
    SBC.
  
  * SD card using either Adafruit (P29) or Sparkfun adapters (P34 or
    P15) of the S100 FPGA Z80 SBC.
  

Note that although this port is for the S100computers FPGA Z80 SBC,
there is currently no support for actually accessing the S100 bus.

This port uses the USB-to-serial board only for input/output. The VGA
and PS/2 ports are not supported yet.

The boot ROM for the system requires that two UARTs be present in the
system, but the FPGA Z80 SBC natively only supports one UART. I have
adopted the trick used by Lawrence documented
[here](https://ve7it.cowlug.org/fpga_gs.html) to repurpose a few of
the parallel port pins as a UART. This second UART is not necessary to
use the system past boot time, but you can use it via the appropriate
cable if desired.

Be sure to add the two SD card pull up resistors mentioned in the
"Notes" section at the bottom of the S100 FPGA Z80 SBC write up linked
above.

## System Software Components

The system software is found in the MC-2G-1024.zip available on the
MC-2G-1024 page mentioned above. Download the ZIP file, extract it,
and write the System18.img file to an SD card.

The MC-2G-1024 contains systems for CP/M 2.2, Dos+ 2.5, CP/M 3.0,
MPMII 2.1, ZSDOS 1.1/ZCPR2, ZPM3/ZCCP and NASCOM ROM Basic. The MPMII
system does not yet work for this port.

## Bitstreams

The FPGA bitstreams are in the `bitstreams` directory. The one with
the `.bit` extension is used for programming via JTAG, while the one
with the `.hex` extensions is used for programming via SPI. Refer to
Jeff's instructions linked above for programming details.

## Efinix Project

To load this project into the Efinix IDE, use the
`Microcomputer_TTY/Microcomputer_TTY.xml` project file. Some changes I
have made from the original MC-2G-1024 files include:

  * Adding an Internal128K.vhd file
  
  * Changing the Z80 ROM files from using an init HEX file to
    hardcoding the byte values directly in VHDL, for simplicity.

You'll need to run `git submodule init` followed by 
`git submodule update` before compiling the code to pull in
the MultiComp base code from an external repository.

## Note for using the Efinix programmer under Linux.

I've noticed that the Efinix programmer software will fail under Linux
of the USB-to-serial board of the FPGA Z80 SBC is plugged into the
Linux computer.  I think the Efinix software gets confused by the
presence of two FTDI devices in the system. Unplug the cable from the
USB-to-serial board before attempting to program.
