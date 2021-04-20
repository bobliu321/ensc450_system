library ieee;
use ieee.std_logic_1164.all;


 entity aesbuffer is
   Port (  clk, resetn  : in  std_logic;
           addr_in      : in  std_logic_vector(31 downto 0); 
		   mr,mw        : in  std_logic;
		   data_in      : in  std_logic_vector(31 downto 0);
           data_out : out std_logic_vector(31 downto 0) );
 end aesbuffer;

 architecture struct of aesbuffer is

  component aes128key
   Port(
	reset : in  STD_LOGIC;
	clock : in  STD_LOGIC;
	--input side signals	
	load : in  STD_LOGIC;
	key : in  STD_LOGIC_VECTOR (127 downto 0);
	plain : in  STD_LOGIC_VECTOR (127 downto 0);
	--output side signals
	cipher : out STD_LOGIC_VECTOR(127 downto 0));
  end component;

  constant writefft_address   : std_logic_vector(31 downto 0) := x"20000000";
  constant computefft_address : std_logic_vector(31 downto 0) := x"20000004";
  constant readfft_address    : std_logic_vector(31 downto 0) := x"20000008";

signal aeskey : std_logic_vector(127 downto 0);
signal aesplain : std_logic_vector(127 downto 0);
signal aeskey1 : std_logic_vector(127 downto 0);
signal aesplain1 : std_logic_vector(127 downto 0);
signal aescipher : std_logic_vector(127 downto 0);
signal aesload: STD_LOGIC;

begin
process (clk, resetn)--input starts
variable IndexA: integer range 0 to 8;
begin
   if rising_edge(clk) then
	if resetn = '0' then
		aeskey <= (Others=>'0');
		aesplain <= (Others=>'0');
		IndexA := 0;
		aesload <= '0';
	else
		if ((IndexA < 3) and mw = '1' and addr_in=writefft_address) then
			aeskey(31 downto 0) <= data_in(31 downto 0);
			aeskey(127 downto 32) <= aeskey(95 downto 0);		
			IndexA := IndexA + 1;
		elsif ((IndexA = 3) and mw = '1' and addr_in=writefft_address)then
			aeskey(127 downto 32) <= aeskey(95 downto 0);	
			aeskey(31 downto 0) <= data_in(31 downto 0);
			IndexA := IndexA + 1;
		elsif ((IndexA > 3 and IndexA < 7) and mw = '1' and addr_in=writefft_address)then
			aesplain(31 downto 0) <= data_in(31 downto 0);
			aesplain(127 downto 32) <= aesplain(95 downto 0);		
			IndexA := IndexA + 1;
		elsif ((IndexA = 7) and mw = '1' and addr_in=writefft_address) then
			aesplain(127 downto 32) <= aesplain(95 downto 0);
			aesplain(31 downto 0) <= data_in(31 downto 0);		
			IndexA := IndexA + 1;
		elsif ((IndexA = 8) and mw = '1' and addr_in=computefft_address) then
			aesload <= '1';
			IndexA := 0;
			aeskey1 <= aeskey;
			aesplain1<=aesplain;
		else
			--IndexA := 0;
			aesload <= '0';
		end if;
	end if;
   end if;
end process;


aes128keyrun: aes128key port map(resetn, clk, aesload, aeskey1(127 downto 0), aesplain1(127 downto 0), aescipher(127 downto 0));


process (clk, resetn)
   variable IndexB: integer range 0 to 3;
begin
   if rising_edge(clk) then
	if resetn = '0' then
		IndexB := 0;
   	else   
      		if (IndexB < 3 and  mr = '1' and addr_in=readfft_address) then
         		data_out <= aescipher(32*(4-IndexB)-1 downto 32*(3-IndexB));
         		IndexB := IndexB + 1;
      		elsif (IndexB = 3 and mr = '1'and addr_in=readfft_address) then
         		data_out <= aescipher(32*(4-IndexB)-1 downto 32*(3-IndexB));
		else
			--IndexB := 0;
			--aesload <= '0';
      		end if;
   	end if;
   end if;
end process;
end struct;

