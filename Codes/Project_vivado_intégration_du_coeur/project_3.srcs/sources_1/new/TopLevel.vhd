----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 22.11.2021 15:50:11
-- Design Name: 
-- Module Name: TopLevel - Behavioral
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


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;


entity MCU_PRJ_2021_TopLevel is
    Port (
        CLK100MHZ : in STD_LOGIC;
        sw : in STD_LOGIC_VECTOR(3 downto 0);
        btn : in STD_LOGIC_VECTOR(3 downto 0);
        led : out STD_LOGIC_VECTOR(3 downto 0);
        led0_r : out STD_LOGIC; led0_g : out STD_LOGIC; led0_b : out STD_LOGIC;                
        led1_r : out STD_LOGIC; led1_g : out STD_LOGIC; led1_b : out STD_LOGIC;
        led2_r : out STD_LOGIC; led2_g : out STD_LOGIC; led2_b : out STD_LOGIC;                
        led3_r : out STD_LOGIC; led3_g : out STD_LOGIC; led3_b : out STD_LOGIC
    );
end MCU_PRJ_2021_TopLevel;

architecture Behavioral of MCU_PRJ_2021_TopLevel is

component coeur is 
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
end component;

signal MyS : std_logic_vector (7 downto 0);

begin

    MyCoeurInst : coeur
    port map(
        A => sw,
        B => sw,
        SR_IN_L => '0',
        SR_IN_R => '0',
        S => MyS,
        SR_OUT_L => led3_b,
        SR_OUT_R => led2_b,
        SEL_FCT => btn
    );
    
    led(3 downto 0) <= MyS(7 downto 4); -- connecter les 4 bits de poids forts a ces leds
    led3_g <= MyS(3);
    led2_g <= MyS(2);
    led1_g <= MyS(1);
    led0_g <= MyS(0);
    
    led0_r <= '0';
    led0_b <= '0';
    led1_r <= '0';
    led1_b <= '0';
    led2_r <= '0';
    led3_r <= '0';
        
         

end Behavioral;
