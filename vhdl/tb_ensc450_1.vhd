-------------------------------------------------------------------------------
-- ensc450 Testbench
--
-------------------------------------------------------------------------------


library ieee;
use ieee.std_logic_1164.all;


entity E is
end E;

Architecture A of E is
constant addr_size : positive := 32;
constant data_size : positive := 32;

component ensc450 
  port ( clk,resetn : in  std_logic;

         -- Master port to control the subsystem from outside (i.e. testbench)
         EXT_NREADY         : out   Std_logic;
         EXT_BUSY           : in    Std_logic;
         EXT_MR, EXT_MW     : in    Std_logic;
         EXT_ADDRBUS        : in    Std_logic_vector(data_size-1 downto 0);
         EXT_RDATABUS       : out   Std_logic_vector(data_size-1 downto 0);
         EXT_WDATABUS       : in    Std_logic_vector(data_size-1 downto 0) );
  end component;

  signal clk,resetn : std_logic;
  signal EXT_NREADY,EXT_BUSY,EXT_MR, EXT_MW : Std_logic;
  signal EXT_ADDRBUS  : Std_logic_vector(addr_size-1 downto 0);
  signal EXT_RDATABUS,EXT_WDATABUS : Std_logic_vector(data_size-1 downto 0);

begin

  UUT : ensc450 port map (clk,resetn,EXT_NREADY,EXT_BUSY,EXT_MR,EXT_MW,EXT_ADDRBUS,EXT_RDATABUS,EXT_WDATABUS);

  EXT_BUSY <= '0';
  
   clock_engine : process
    begin
      clk <= '0';
      wait for 10 ns;
      clk <= '1';
      wait for 10 ns;
    end process;

    reset_engine : process
      begin
        resetn <='0';
        wait for 20 ns;
        resetn <= '1';
        wait;
    end process;

    -- Please enter here the test data dor the memory and the programming for Counter and TMA
    -- In this example the tb is loading 16 data on the main memory and then
    -- the testbench is transferring the same to a different location.
    -- Detailed instruction on how to use counter and DMA are at the beginning
    -- of the repsective VHDL files
    input_data : process
      begin
        EXT_MR <= '0';EXT_MW <= '0';EXT_ADDRBUS<= X"00000000";EXT_WDATABUS<= X"00000000";
        wait for 45 ns;
        -- Example 1: Resetting and Starting counter
        EXT_MR <= '0';EXT_MW <= '1';EXT_ADDRBUS<= X"b0000010";EXT_WDATABUS<= X"00000000";
        wait for 20 ns;
        EXT_MR <= '0';EXT_MW <= '1';EXT_ADDRBUS<= X"b0000020";EXT_WDATABUS<= X"00000000";
        wait for 20 ns;
        -- Example 2: Sending 16 data words to SRAM memory
        
        -----------------------------------------------------------------------
        EXT_MR <= '0';EXT_MW <= '0';EXT_ADDRBUS<= X"00000000";EXT_WDATABUS<= X"00000000";
        wait for 20 ns;
        -- Example 3: Setting a DMA Transfer
        
        -- Example4: Running computation on block: Give some time to complete DMA Transfer
        EXT_MR <= '0';EXT_MW <= '0';EXT_ADDRBUS<= X"00000000";EXT_WDATABUS<= X"00000000";
        wait for 2000 ns;
        --                                          FFT Compute (specific command needed by this IP, your IP may be different)
        EXT_MR <= '0';EXT_MW <= '1';EXT_ADDRBUS<= X"20000000";EXT_WDATABUS<= X"00010203";
        wait for 20 ns;
        EXT_MR <= '0';EXT_MW <= '1';EXT_ADDRBUS<= X"20000000";EXT_WDATABUS<= X"04050607";
        wait for 20 ns;
        EXT_MR <= '0';EXT_MW <= '1';EXT_ADDRBUS<= X"20000000";EXT_WDATABUS<= X"08090a0b";
        wait for 20 ns;
        EXT_MR <= '0';EXT_MW <= '1';EXT_ADDRBUS<= X"20000000";EXT_WDATABUS<= X"0c0d0e0f";
        wait for 20 ns;
        EXT_MR <= '0';EXT_MW <= '1';EXT_ADDRBUS<= X"20000000";EXT_WDATABUS<= X"00112233";
        wait for 20 ns;
        EXT_MR <= '0';EXT_MW <= '1';EXT_ADDRBUS<= X"20000000";EXT_WDATABUS<= X"44556677";
        wait for 20 ns;
        EXT_MR <= '0';EXT_MW <= '1';EXT_ADDRBUS<= X"20000000";EXT_WDATABUS<= X"8899aabb";
        wait for 20 ns;
        EXT_MR <= '0';EXT_MW <= '1';EXT_ADDRBUS<= X"20000000";EXT_WDATABUS<= X"ccddeeff";
        wait for 20 ns;
	EXT_MR <= '0';EXT_MW <= '1';EXT_ADDRBUS<= X"20000004";EXT_WDATABUS<= X"00000000";
        wait for 1000 ns;
        EXT_MR <= '1';EXT_MW <= '0';EXT_ADDRBUS<= X"20000008";EXT_WDATABUS<= X"00000000";
        wait for 20 ns;
        EXT_MR <= '1';EXT_MW <= '0';EXT_ADDRBUS<= X"20000008";EXT_WDATABUS<= X"00000000";
        wait for 20 ns;
        EXT_MR <= '1';EXT_MW <= '0';EXT_ADDRBUS<= X"20000008";EXT_WDATABUS<= X"00000000";
        wait for 20 ns;
        EXT_MR <= '1';EXT_MW <= '0';EXT_ADDRBUS<= X"20000008";EXT_WDATABUS<= X"00000000";
        wait for 20 ns;

        -- Now setting new DMA transfer to read data from block:  Source address
        
        -- D M A Goooooooooooooooooooooooooooooooooooooooo!
        
                
        -- Reading counter value to measure performance
        EXT_MR <= '1';EXT_MW <= '0';EXT_ADDRBUS<= X"b0000000";EXT_WDATABUS<= X"00000000";
        wait for 20 ns;
        EXT_MR <= '0';EXT_MW <= '0';EXT_ADDRBUS<= X"00000000";EXT_WDATABUS<= X"00000000";
        wait;
    end process;
end A;
