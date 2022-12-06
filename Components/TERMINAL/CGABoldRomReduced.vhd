-- This ROM file has been automatically generated from the HEX file CGAFontBoldReduced.HEX
--     command: hex2vhdl.tcl CGABoldRomReduced 1024 CGAFontBoldReduced.HEX
-- Do not edit.

LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_unsigned.all;

ENTITY CGABoldRomReduced IS
PORT
(
    address  : IN STD_LOGIC_VECTOR (9 DOWNTO 0);
    clock    : IN STD_LOGIC  := '1';
    q        : OUT STD_LOGIC_VECTOR (7 DOWNTO 0)
);
END CGABoldRomReduced;

ARCHITECTURE SYN OF CGABoldRomReduced IS
    TYPE rom_type IS ARRAY (0 to 1023) OF std_logic_vector(7 downto 0);

    SIGNAL ROM : rom_type := (

        X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"7e", X"81", X"a5", X"81", X"bd", X"99", X"81", X"7e", 
        X"7e", X"ff", X"db", X"ff", X"c3", X"e7", X"ff", X"7e", X"6c", X"fe", X"fe", X"fe", X"7c", X"38", X"10", X"00", 
        X"10", X"38", X"7c", X"fe", X"7c", X"38", X"10", X"00", X"38", X"7c", X"38", X"fe", X"fe", X"d6", X"10", X"38", 
        X"10", X"10", X"38", X"7c", X"fe", X"7c", X"10", X"38", X"00", X"00", X"18", X"3c", X"3c", X"18", X"00", X"00", 
        X"ff", X"ff", X"e7", X"c3", X"c3", X"e7", X"ff", X"ff", X"00", X"3c", X"66", X"42", X"42", X"66", X"3c", X"00", 
        X"ff", X"c3", X"99", X"bd", X"bd", X"99", X"c3", X"ff", X"0f", X"07", X"0f", X"7d", X"cc", X"cc", X"cc", X"78", 
        X"3c", X"66", X"66", X"66", X"3c", X"18", X"7e", X"18", X"3f", X"33", X"3f", X"30", X"30", X"70", X"f0", X"e0", 
        X"7f", X"63", X"7f", X"63", X"63", X"67", X"e6", X"c0", X"18", X"db", X"3c", X"e7", X"e7", X"3c", X"db", X"18", 
        X"80", X"e0", X"f8", X"fe", X"f8", X"e0", X"80", X"00", X"02", X"0e", X"3e", X"fe", X"3e", X"0e", X"02", X"00", 
        X"18", X"3c", X"7e", X"18", X"18", X"7e", X"3c", X"18", X"66", X"66", X"66", X"66", X"66", X"00", X"66", X"00", 
        X"7f", X"db", X"db", X"7b", X"1b", X"1b", X"1b", X"00", X"3e", X"63", X"38", X"6c", X"6c", X"38", X"cc", X"78", 
        X"00", X"00", X"00", X"00", X"7e", X"7e", X"7e", X"00", X"18", X"3c", X"7e", X"18", X"7e", X"3c", X"18", X"ff", 
        X"18", X"3c", X"7e", X"18", X"18", X"18", X"18", X"00", X"18", X"18", X"18", X"18", X"7e", X"3c", X"18", X"00", 
        X"00", X"18", X"0c", X"fe", X"0c", X"18", X"00", X"00", X"00", X"30", X"60", X"fe", X"60", X"30", X"00", X"00", 
        X"00", X"00", X"c0", X"c0", X"c0", X"fe", X"00", X"00", X"00", X"24", X"66", X"ff", X"66", X"24", X"00", X"00", 
        X"00", X"18", X"3c", X"7e", X"ff", X"ff", X"00", X"00", X"00", X"ff", X"ff", X"7e", X"3c", X"18", X"00", X"00", 
        X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"30", X"78", X"78", X"30", X"30", X"00", X"30", X"00", 
        X"6c", X"6c", X"6c", X"00", X"00", X"00", X"00", X"00", X"6c", X"6c", X"fe", X"6c", X"fe", X"6c", X"6c", X"00", 
        X"30", X"7c", X"c0", X"78", X"0c", X"f8", X"30", X"00", X"00", X"c6", X"cc", X"18", X"30", X"66", X"c6", X"00", 
        X"38", X"6c", X"38", X"76", X"dc", X"cc", X"76", X"00", X"60", X"60", X"c0", X"00", X"00", X"00", X"00", X"00", 
        X"18", X"30", X"60", X"60", X"60", X"30", X"18", X"00", X"60", X"30", X"18", X"18", X"18", X"30", X"60", X"00", 
        X"00", X"66", X"3c", X"ff", X"3c", X"66", X"00", X"00", X"00", X"30", X"30", X"fc", X"30", X"30", X"00", X"00", 
        X"00", X"00", X"00", X"00", X"00", X"30", X"30", X"60", X"00", X"00", X"00", X"fc", X"00", X"00", X"00", X"00", 
        X"00", X"00", X"00", X"00", X"00", X"30", X"30", X"00", X"06", X"0c", X"18", X"30", X"60", X"c0", X"80", X"00", 
        X"7c", X"c6", X"ce", X"de", X"f6", X"e6", X"7c", X"00", X"30", X"70", X"30", X"30", X"30", X"30", X"fc", X"00", 
        X"78", X"cc", X"0c", X"38", X"60", X"cc", X"fc", X"00", X"78", X"cc", X"0c", X"38", X"0c", X"cc", X"78", X"00", 
        X"1c", X"3c", X"6c", X"cc", X"fe", X"0c", X"1e", X"00", X"fc", X"c0", X"f8", X"0c", X"0c", X"cc", X"78", X"00", 
        X"38", X"60", X"c0", X"f8", X"cc", X"cc", X"78", X"00", X"fc", X"cc", X"0c", X"18", X"30", X"30", X"30", X"00", 
        X"78", X"cc", X"cc", X"78", X"cc", X"cc", X"78", X"00", X"78", X"cc", X"cc", X"7c", X"0c", X"18", X"70", X"00", 
        X"00", X"30", X"30", X"00", X"00", X"30", X"30", X"00", X"00", X"30", X"30", X"00", X"00", X"30", X"30", X"60", 
        X"18", X"30", X"60", X"c0", X"60", X"30", X"18", X"00", X"00", X"00", X"fc", X"00", X"00", X"fc", X"00", X"00", 
        X"60", X"30", X"18", X"0c", X"18", X"30", X"60", X"00", X"78", X"cc", X"0c", X"18", X"30", X"00", X"30", X"00", 
        X"7c", X"c6", X"de", X"de", X"de", X"c0", X"78", X"00", X"30", X"78", X"cc", X"cc", X"fc", X"cc", X"cc", X"00", 
        X"fc", X"66", X"66", X"7c", X"66", X"66", X"fc", X"00", X"3c", X"66", X"c0", X"c0", X"c0", X"66", X"3c", X"00", 
        X"f8", X"6c", X"66", X"66", X"66", X"6c", X"f8", X"00", X"fe", X"62", X"68", X"78", X"68", X"62", X"fe", X"00", 
        X"fe", X"62", X"68", X"78", X"68", X"60", X"f0", X"00", X"3c", X"66", X"c0", X"c0", X"ce", X"66", X"3e", X"00", 
        X"cc", X"cc", X"cc", X"fc", X"cc", X"cc", X"cc", X"00", X"78", X"30", X"30", X"30", X"30", X"30", X"78", X"00", 
        X"1e", X"0c", X"0c", X"0c", X"cc", X"cc", X"78", X"00", X"e6", X"66", X"6c", X"78", X"6c", X"66", X"e6", X"00", 
        X"f0", X"60", X"60", X"60", X"62", X"66", X"fe", X"00", X"c6", X"ee", X"fe", X"fe", X"d6", X"c6", X"c6", X"00", 
        X"c6", X"e6", X"f6", X"de", X"ce", X"c6", X"c6", X"00", X"38", X"6c", X"c6", X"c6", X"c6", X"6c", X"38", X"00", 
        X"fc", X"66", X"66", X"7c", X"60", X"60", X"f0", X"00", X"78", X"cc", X"cc", X"cc", X"dc", X"78", X"1c", X"00", 
        X"fc", X"66", X"66", X"7c", X"6c", X"66", X"e6", X"00", X"78", X"cc", X"60", X"30", X"18", X"cc", X"78", X"00", 
        X"fc", X"b4", X"30", X"30", X"30", X"30", X"78", X"00", X"cc", X"cc", X"cc", X"cc", X"cc", X"cc", X"fc", X"00", 
        X"cc", X"cc", X"cc", X"cc", X"cc", X"78", X"30", X"00", X"c6", X"c6", X"c6", X"d6", X"fe", X"ee", X"c6", X"00", 
        X"c6", X"c6", X"6c", X"38", X"38", X"6c", X"c6", X"00", X"cc", X"cc", X"cc", X"78", X"30", X"30", X"78", X"00", 
        X"fe", X"c6", X"8c", X"18", X"32", X"66", X"fe", X"00", X"78", X"60", X"60", X"60", X"60", X"60", X"78", X"00", 
        X"c0", X"60", X"30", X"18", X"0c", X"06", X"02", X"00", X"78", X"18", X"18", X"18", X"18", X"18", X"78", X"00", 
        X"10", X"38", X"6c", X"c6", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"ff", 
        X"30", X"30", X"18", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"78", X"0c", X"7c", X"cc", X"76", X"00", 
        X"e0", X"60", X"60", X"7c", X"66", X"66", X"dc", X"00", X"00", X"00", X"78", X"cc", X"c0", X"cc", X"78", X"00", 
        X"1c", X"0c", X"0c", X"7c", X"cc", X"cc", X"76", X"00", X"00", X"00", X"78", X"cc", X"fc", X"c0", X"78", X"00", 
        X"38", X"6c", X"60", X"f0", X"60", X"60", X"f0", X"00", X"00", X"00", X"76", X"cc", X"cc", X"7c", X"0c", X"f8", 
        X"e0", X"60", X"6c", X"76", X"66", X"66", X"e6", X"00", X"30", X"00", X"70", X"30", X"30", X"30", X"78", X"00", 
        X"0c", X"00", X"0c", X"0c", X"0c", X"cc", X"cc", X"78", X"e0", X"60", X"66", X"6c", X"78", X"6c", X"e6", X"00", 
        X"70", X"30", X"30", X"30", X"30", X"30", X"78", X"00", X"00", X"00", X"cc", X"fe", X"fe", X"d6", X"c6", X"00", 
        X"00", X"00", X"f8", X"cc", X"cc", X"cc", X"cc", X"00", X"00", X"00", X"78", X"cc", X"cc", X"cc", X"78", X"00", 
        X"00", X"00", X"dc", X"66", X"66", X"7c", X"60", X"f0", X"00", X"00", X"76", X"cc", X"cc", X"7c", X"0c", X"1e", 
        X"00", X"00", X"dc", X"76", X"66", X"60", X"f0", X"00", X"00", X"00", X"7c", X"c0", X"78", X"0c", X"f8", X"00", 
        X"10", X"30", X"7c", X"30", X"30", X"34", X"18", X"00", X"00", X"00", X"cc", X"cc", X"cc", X"cc", X"76", X"00", 
        X"00", X"00", X"cc", X"cc", X"cc", X"78", X"30", X"00", X"00", X"00", X"c6", X"d6", X"fe", X"fe", X"6c", X"00", 
        X"00", X"00", X"c6", X"6c", X"38", X"6c", X"c6", X"00", X"00", X"00", X"cc", X"cc", X"cc", X"7c", X"0c", X"f8", 
        X"00", X"00", X"fc", X"98", X"30", X"64", X"fc", X"00", X"1c", X"30", X"30", X"e0", X"30", X"30", X"1c", X"00", 
        X"18", X"18", X"18", X"00", X"18", X"18", X"18", X"00", X"e0", X"30", X"30", X"1c", X"30", X"30", X"e0", X"00", 
        X"76", X"dc", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"10", X"38", X"6c", X"c6", X"c6", X"fe", X"00"

    );
BEGIN
    PROCESS(clock)
    BEGIN
        IF rising_edge(clock) THEN
            q <= ROM(conv_integer(address));
        END IF;
    END PROCESS;
END SYN;
