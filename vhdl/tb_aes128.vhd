library ieee;
use ieee.std_logic_1164.all;



entity E is
end E;

Architecture A of E is
constant addr_size : positive := 32;
constant data_size : positive := 32;

component aesbuffer 
  Port (  clk, resetn  : in  std_logic;
           addr_in      : in  std_logic_vector(31 downto 0); 
		   mr,mw        : in  std_logic;
		   data_in      : in  std_logic_vector(31 downto 0);
           data_out : out std_logic_vector(31 downto 0) );
  end component;

  signal clk,resetn : std_logic;
  signal EXT_MR, EXT_MW : Std_logic;
  signal EXT_ADDRBUS  : Std_logic_vector(addr_size-1 downto 0);
  signal EXT_RDATABUS,EXT_WDATABUS : Std_logic_vector(data_size-1 downto 0);

begin

  UUT : aesbuffer port map (clk,resetn,EXT_ADDRBUS,EXT_MR,EXT_MW,EXT_WDATABUS,EXT_RDATABUS);

  
   clk_engine : process
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
        wait;
	end process;
end A;
