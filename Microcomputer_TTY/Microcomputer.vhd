-- This file is copyright by Grant Searle 2014
-- You are free to use this file in your own projects but must never charge for it nor use it without
-- acknowledgement.
-- Please ask permission from Grant Searle before republishing elsewhere.
-- If you use this file or any part of it, please add an acknowledgement to myself and
-- a link back to my main web site http://searle.hostei.com/grant/    
-- and to the "multicomp" page at http://searle.hostei.com/grant/Multicomp/index.html
--
-- Please check on the above web pages to see if there are any updates before using this file.
-- If for some reason the page is no longer available, please search for "Grant Searle"
-- on the internet to see if I have moved to another web hosting service.
--
-- Grant Searle
-- eMail address available on my main web page link above.

library ieee;
use ieee.std_logic_1164.all;
use  IEEE.STD_LOGIC_ARITH.all;
use  IEEE.STD_LOGIC_UNSIGNED.all;

entity Microcomputer is
	port(
		n_reset		: in std_logic;
		clk			: in std_logic;

		rxd1			: in std_logic;
		txd1			: out std_logic;
		rts1			: out std_logic;
--		cts1			: in std_logic;

		rxd2			: in std_logic;
		txd2			: out std_logic;
		rts2			: out std_logic;
--		cts2			: in std_logic;

		sdCS			: out std_logic;
		sdMOSI		: out std_logic;
		sdMISO		: in std_logic;
		sdSCLK		: out std_logic;
		driveLED		: out std_logic := '1'
	);
end Microcomputer;

architecture struct of Microcomputer is

	signal cpuClock					: std_logic;
	signal n_WR						: std_logic;
	signal n_RD						: std_logic;
	signal cpuAddress				: std_logic_vector(15 downto 0);
	signal cpuDataOut				: std_logic_vector(7 downto 0);
	signal cpuDataIn				: std_logic_vector(7 downto 0);

	signal n_memWR					: std_logic := '1';
	signal n_memRD 					: std_logic := '1';

	signal n_ioWR					: std_logic := '1';
	signal n_ioRD 					: std_logic := '1';

	signal n_MREQ					: std_logic := '1';
	signal n_IORQ					: std_logic := '1';

	signal n_M1						: std_logic := '1';

	signal monRomData				: std_logic_vector(7 downto 0);
	signal n_monRomCS				: std_logic := '1';
	signal n_RomActive 				: std_logic := '0';

	signal physicaladdr				: std_logic_vector(19 downto 0);
	signal internalRam1DataOut      : std_logic_vector(7 downto 0);
	signal n_internalRam1CS         : std_logic := '1';
	signal n_mmuCS					: std_logic := '1';

	signal intClkCount				: std_logic_vector(19 downto 0);
	signal n_int50					: std_logic;

	signal interface1DataOut		: std_logic_vector(7 downto 0);
	signal n_int1					: std_logic := '1';
	signal n_interface1CS			: std_logic := '1';
	signal n_brg1					: std_logic := '1';
	signal sClk1					: std_logic;

	signal interface2DataOut		: std_logic_vector(7 downto 0);
	signal n_int2					: std_logic := '1';
	signal n_interface2CS			: std_logic := '1';
	signal n_brg2					: std_logic := '1';
	signal sClk2					: std_logic;

	signal sdCardDataOut			: std_logic_vector(7 downto 0);
	signal n_sdCardCS				: std_logic := '1';

begin

-- CPM
-- Disable ROM if "OUT 38". Re-enable when (asynchronous) reset pressed or if "OUT 39".
	process (n_ioWR, n_reset) begin
		if (n_reset = '0') then
			n_RomActive <= '0';
		elsif (rising_edge(n_ioWR)) then
			if cpuAddress(7 downto 0) = "00111000" then 		-- $38
				n_RomActive <= '1';
			elsif cpuAddress(7 downto 0) = "00111001" then 	-- $39
				n_RomActive <= '0';
			end if;
		end if;
	end process;

-- ____________________________________________________________________________________
-- CPU CHOICE GOES HERE
	cpu1 : entity work.t80s
	generic map(
		mode 		=> 1, 
		t2write 	=> 1, 
		iowait 	=> 0
	)
	port map(
		reset_n 	=> n_reset,
		clk_n 	=> cpuClock,
		wait_n 	=> '1',
		int_n 	=> n_int50,
		nmi_n 	=> '1',
		busrq_n 	=> '1',
		mreq_n 	=> n_MREQ,
		iorq_n 	=> n_IORQ,
		rd_n 		=> n_RD,
		wr_n 		=> n_WR,
		m1_n 		=> n_M1,
		a 			=> cpuAddress,
		di 		=> cpuDataIn,
		do 		=> cpuDataOut
	);
-- ____________________________________________________________________________________
-- ROM GOES HERE
	rom1 : entity work.Z80_CMON_ROM -- 2KB CP/M monitor
	port map(
		address => cpuAddress(10 downto 0), 
		clock => clk,
		q => monRomData
	);
-- ____________________________________________________________________________________
-- RAM GOES HERE
	MemoryManagement : entity work.MMU4
	port map(
		clk 			=> cpuClock, 				-- clock based on divided cpu clock
		n_wr 			=> n_mmuCS or n_ioWR, 	-- group of 8 ports to write data to the MMU
		n_rd 			=> n_mmuCS or n_ioRD, 	-- future use, for reading data back from the MMU
		mmu_reset 	=> n_reset, 				-- and pin73RCreset, -- pushbutton reset low or RC startup low
		dataIn 		=> cpuDataOut, 			-- data lines to send commands to the MMU
		cpuAddress 	=> cpuAddress, 			-- cpu Adress lines to the MMU
		mmuAddressOut => physicaladdr 		-- modified address lines from the MMU
	);

	ram1: entity work.InternalRam128K
        port map (
            address => physicaladdr(16 downto 0),
            clock => clk,
            data => cpuDataOut,
            wren => not(n_memWR or n_internalRam1CS),
            q => internalRam1DataOut
        );

-- ____________________________________________________________________________________
-- INPUT/OUTPUT DEVICES GO HERE
	io1 : entity work.bufferedUART
	port map(
		clk 		=> clk,
		n_wr 		=> n_interface1CS or n_ioWR,
		n_rd 		=> n_interface1CS or n_ioRD,
		n_int 	=> n_int1,
		regSel 	=> cpuAddress(0),
		dataIn 	=> cpuDataOut,
		dataOut 	=> interface1DataOut,
		rxClock 	=> sClk1,
		txClock 	=> sClk1,
		rxd 		=> rxd1,
		txd 		=> txd1,
		n_cts		=> '0',
		n_dcd 	=> '0',
		n_rts 	=> rts1
	);

	brg1 : entity work.brg
	port map(
		clk      => clk,
		n_reset  => n_reset,
		baud_clk => sClk1, 
		n_wr 		=> n_ioWR,
		n_cs 		=> n_brg1,
		dataIn 	=> cpuDataOut
	);

	io2 : entity work.bufferedUART
	port map(
		clk 		=> clk,
		n_wr 		=> n_interface2CS or n_ioWR,
		n_rd 		=> n_interface2CS or n_ioRD,
		n_int 	=> n_int2,
		regSel 	=> cpuAddress(0),
		dataIn 	=> cpuDataOut,
		dataOut 	=> interface2DataOut,
		rxClock 	=> sClk2,
		txClock 	=> sClk2,
		rxd 		=> rxd2,
		txd 		=> txd2,
		n_cts		=> '0',
		n_dcd 	=> '0',
		n_rts 	=> rts2
	);

	brg2 : entity work.brg
	port map(
		clk      => clk,
		n_reset  => n_reset,
		baud_clk => sClk2, 
		n_wr 		=> n_ioWR,
		n_cs 		=> n_brg2,
		dataIn 	=> cpuDataOut
   );

	sd1 : entity work.sd_controller 
	port map(
		sdCS 		=> sdCS,
		sdMOSI		=> sdMOSI,
		sdMISO		=> sdMISO,
		sdSCLK		=> sdSCLK,
		n_wr		=> n_sdCardCS or n_ioWR,
		n_rd 		=> n_sdCardCS or n_ioRD,
		n_reset 	=> n_reset,
		dataIn		=> cpuDataOut,
		dataOut 	=> sdCardDataOut,
		regAddr 	=> cpuAddress(2 downto 0),
		driveLED	=> driveLED,
		clk			=> clk		-- 50 MHz clock = 25 MHz SPI clock
	);

-- ____________________________________________________________________________________
-- MEMORY READ/WRITE LOGIC GOES HERE
	n_ioWR 			<= n_WR or n_IORQ;
	n_memWR 		<= n_WR or n_MREQ;
	n_ioRD 			<= n_RD or n_IORQ;
	n_memRD 		<= n_RD or n_MREQ;

-- ____________________________________________________________________________________
-- CHIP SELECTS GO HERE
	n_monRomCS 		<= '0' when cpuAddress(15 downto 11) = "00000" and n_RomActive = '0' else '1'; 					-- 2K low memory
	n_brg1 			<= '0' when cpuAddress(7 downto 0) = "01111011" and (n_ioWR = '0' or n_ioRD = '0') else '1'; 	-- 1 Byte 	$7B
	n_brg2 			<= '0' when cpuAddress(7 downto 0) = "01111100" and (n_ioWR = '0' or n_ioRD = '0') else '1'; 	-- 1 Byte 	$7C
	n_interface1CS <= '0' when cpuAddress(7 downto 1) = "1000000" and (n_ioWR = '0' or n_ioRD = '0') else '1'; 	-- 2 Bytes 	$80-$81
	n_interface2CS <= '0' when cpuAddress(7 downto 1) = "1000001" and (n_ioWR = '0' or n_ioRD = '0') else '1'; 	-- 2 Bytes 	$82-$83
	n_sdCardCS 		<= '0' when cpuAddress(7 downto 3) = "10001" and (n_ioWR = '0' or n_ioRD = '0') else '1'; 		-- 8 Bytes 	$88-$8F
	n_mmuCS 			<= '0' when cpuAddress(7 downto 3) = "11111" and (n_ioWR = '0' or n_ioRD = '0') else '1'; 		-- 8 bytes 	$F8-$FF
    n_internalRam1CS <= not(n_monRomCS);
-- ____________________________________________________________________________________
-- BUS ISOLATION GOES HERE
	cpuDataIn <=
		interface1DataOut when n_interface1CS = '0' else
		interface2DataOut when n_interface2CS = '0' else
		sdCardDataOut when n_sdCardCS = '0' else
		monRomData when n_monRomCS = '0' else
		internalRam1DataOut when n_internalRam1CS = '0' else
		x"FF";
-- ____________________________________________________________________________________
-- SYSTEM CLOCKS GO HERE
	-- SUB-CIRCUIT CLOCK SIGNALS 

	process (clk)
	begin
	if rising_edge(clk) then

	   CPUClock <= not CPUClock;			--25 MHz

		if intClkCount < 999999 then		-- 1,000,000 for 50 Hz
			intClkCount <= intClkCount +1;
		else
			intClkCount <= (others=>'0');
			n_int50 <= '0';
		end if;
		if n_int50 = '0' then				-- interrupt acknowledge
			if ( n_IORQ = '0' ) and ( n_M1 = '0' ) then
				n_int50 <= '1';
			end if;
		end if;

	end if;
	end process;
end;
