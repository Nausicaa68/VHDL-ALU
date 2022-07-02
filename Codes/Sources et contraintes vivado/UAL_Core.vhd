----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 22.11.2021 15:37:14
-- Design Name: 
-- Module Name: UAL_Core - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------

-- Code your design here
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_signed.all;


-- Ce coeur de microcontroleur fonctionnera sur 4 bits signes pour les entrees et sur 8 bits pour les sorties et les memoires internes
entity coeur is
port (
	A : in std_logic_vector (3 downto 0); 
    B : in std_logic_vector (3 downto 0); 
    SR_IN_L : in std_logic;
    SR_IN_R : in std_logic;
	SEL_FCT : in std_logic_vector (3 downto 0); --selection sur 4bits
    S : out std_logic_vector (7 downto 0);
    SR_OUT_L : out std_logic;
    SR_OUT_R : out std_logic
);
end coeur;

--16 fonctions seront 16 process
architecture coeur_Arch of coeur is

	signal My_A, My_B : std_logic_vector(3 downto 0);
    signal My_SR_IN_R, My_SR_IN_L, My_SR_OUT_R, My_SR_OUT_L : std_logic;
    signal My_S : std_logic_vector (7 downto 0);
    
begin  

	-- process explicite 
    coeurProc : process (SEL_FCT, A, B, SR_IN_R, SR_IN_L)
    variable My_S_var, My_A_var, My_B_var : std_logic_vector(7 downto 0);
    begin
    	case SEL_FCT is
            when "0000" =>
                S (7 downto 0) <= (others => '0');
                SR_OUT_L <= '0';
                SR_OUT_R <= '0';
                
            when "0001" =>
            	S (7 downto 4) <= (others => '0');
                S (3 downto 0) <= A;
                SR_OUT_L <= '0'; 
                SR_OUT_R <= '0';
                
            when "0010" =>
                S (7 downto 4) <= (others => '0');
                S (3 downto 0) <= B;
                SR_OUT_L <= '0';
                SR_OUT_R <= '0';
                
            when "0011" =>
                S (7 downto 4) <= (others => '0');
                S (3 downto 0) <= not A;
                SR_OUT_L <= '0';
                SR_OUT_R <= '0';
                
            when "0100" =>
                S (7 downto 4) <= (others => '0');
                S (3 downto 0) <= not B;
                SR_OUT_L <= '0';
                SR_OUT_R <= '0';
                
            when "0101" =>
                S (7 downto 4) <= (others => '0');
                S (3 downto 0) <= A and B;
                SR_OUT_L <= '0';
                SR_OUT_R <= '0';
                
            when "0110" =>
                S (7 downto 4) <= (others => '0');
                S (3 downto 0) <= A or B;
                SR_OUT_L <= '0';
                SR_OUT_R <= '0';
                
            when "0111" =>
                S (7 downto 4) <= (others => '0');
                S (3 downto 0) <= A xor B;
                SR_OUT_L <= '0';
                SR_OUT_R <= '0';   
                
            when "1000" => --dec droite de A
                S (7 downto 4) <= (others => '0');
                SR_OUT_R <= A(0);
                S(0) <= A(1);
                S(1) <= A(2);
                S(2) <= A(3);
                S(3) <= SR_IN_L;
                SR_OUT_L <= '0';
                
            when "1001" => --dec gauche de A
                S (7 downto 4) <= (others => '0');
                SR_OUT_L <= A(3);
                S(3) <= A(2);
                S(2) <= A(1);
                S(1) <= A(0);
                S(0) <= SR_IN_R;
                SR_OUT_R <= '0';
                
            when "1010" => --dec droite de B
                S (7 downto 4) <= (others => '0');
                SR_OUT_R <= B(0);
                S(0) <= B(1);
                S(1) <= B(2);
                S(2) <= B(3);
                S(3) <= SR_IN_L;
                SR_OUT_L <= '0';
                
            when "1011" => --dec gauche de B
                S (7 downto 4) <= (others => '0');
                SR_OUT_L <= B(3);
                S(3) <= B(2);
                S(2) <= B(1);
                S(1) <= B(0);
                S(0) <= SR_IN_R;
                SR_OUT_R <= '0';
                
            when "1100" => -- S = A + B addition binaire avec SR_IN_R comme retenue d entree
            	My_A_var (3 downto 0) := A; My_B_var (3 downto 0) := B;
                My_A_var (7 downto 4) := (others => A(3)); My_B_var (7 downto 4) := (others => B(3));
                My_S_var := My_A_var + My_B_var;
                My_S_var := My_S_var + ("0000000" & SR_IN_R);
               	S <= My_S_var;
                SR_OUT_L <= '0';
                SR_OUT_R <= '0';
                
            when "1101" => --S = A + B addition binaire sans retenue
            	My_A_var (3 downto 0) := A; My_B_var (3 downto 0) := B;
                My_A_var (7 downto 4) := (others => A(3)); My_B_var (7 downto 4) := (others => B(3));
                My_S_var := My_A_var + My_B_var;
               	S <= My_S_var;
                SR_OUT_L <= '0';
                SR_OUT_R <= '0';
                
            when "1110" => --S = A + B soustraction binaire sans retenue
            	My_A_var (3 downto 0) := A; My_B_var (3 downto 0) := B;
                My_A_var (7 downto 4) := (others => A(3)); My_B_var (7 downto 4) := (others => B(3));
                My_S_var := My_A_var - My_B_var;
               	S <= My_S_var;
                SR_OUT_L <= '0';
                SR_OUT_R <= '0';

            when others =>  --ici c'est 1111 donc la multiplication binaire
              	S <= A*B;
                SR_OUT_L <= '0';
                SR_OUT_R <= '0';
       end case;
                
    end process;
    
end coeur_Arch; 