LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;

-- Adapted from Pages 13-27:28 of "Recommended HDL Coding Styles"
-- https://www.intel.com/content/dam/www/programmable/us/en/pdfs/literature/hb/qts/qts_qii51007.pdf

ENTITY DisplayRam1K IS    
    PORT
    (
        clock        : IN STD_LOGIC;
        address_a    : IN STD_LOGIC_VECTOR(9 DOWNTO 0);
        address_b    : IN STD_LOGIC_VECTOR(9 DOWNTO 0);
        data_a       : IN STD_LOGIC_VECTOR (7 DOWNTO 0);
        data_b       : IN STD_LOGIC_VECTOR (7 DOWNTO 0);
        wren_a       : IN STD_LOGIC  := '0';
        wren_b       : IN STD_LOGIC  := '0';
        q_a          : OUT STD_LOGIC_VECTOR (7 DOWNTO 0);
        q_b          : OUT STD_LOGIC_VECTOR (7 DOWNTO 0)
    );
END DisplayRam1K;


ARCHITECTURE SYN OF DisplayRam1K IS
    SUBTYPE word_t IS STD_LOGIC_VECTOR(7 downto 0);
    TYPE memory_t is array (1023 downto 0) of word_t;
    SHARED VARIABLE RAM : memory_t;

BEGIN
    PROCESS (clock)
        VARIABLE aia: INTEGER;
    BEGIN
        IF rising_edge(clock) THEN
            aia := to_integer(unsigned(address_a));
            IF wren_a = '1' THEN
                RAM(aia) := data_a;
            END IF;
            q_a <= RAM(aia);
        END IF;
    END PROCESS;
     
    PROCESS(clock)
        VARIABLE aib : INTEGER;
    BEGIN
        IF rising_edge(clock) THEN
            aib := to_integer(unsigned(address_b));
            IF wren_b = '1' THEN
                RAM(aib) := data_b;
            END IF;
            q_b <= RAM(aib);
        END IF;
    END PROCESS;
END SYN;
