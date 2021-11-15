-- Copyright (C) 1991-2016 Altera Corporation. All rights reserved.
-- Your use of Altera Corporation's design tools, logic functions 
-- and other software and tools, and its AMPP partner logic 
-- functions, and any output files from any of the foregoing 
-- (including device programming or simulation files), and any 
-- associated documentation or information are expressly subject 
-- to the terms and conditions of the Altera Program License 
-- Subscription Agreement, the Altera Quartus Prime License Agreement,
-- the Altera MegaCore Function License Agreement, or other 
-- applicable license agreement, including, without limitation, 
-- that your use is for the sole purpose of programming logic 
-- devices manufactured by Altera and sold by Altera or its 
-- authorized distributors.  Please refer to the applicable 
-- agreement for further details.

-- PROGRAM		"Quartus Prime"
-- VERSION		"Version 16.0.0 Build 211 04/27/2016 SJ Lite Edition"
-- CREATED		"Sun Sep 17 23:36:53 2017"

LIBRARY ieee;
USE ieee.std_logic_1164.all; 

LIBRARY work;

ENTITY Lab1 IS 
	PORT
	(
		SW :  IN  STD_LOGIC_VECTOR(5 DOWNTO 0);
		LEDR :  OUT  STD_LOGIC_VECTOR(1 DOWNTO 0)
	);
END Lab1;

ARCHITECTURE bdf_type OF Lab1 IS 

SIGNAL	SYNTHESIZED_WIRE_0 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_1 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_2 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_3 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_4 :  STD_LOGIC;


BEGIN 



SYNTHESIZED_WIRE_2 <= SW(0) AND SYNTHESIZED_WIRE_0;


SYNTHESIZED_WIRE_1 <= SW(1) AND SW(2);


LEDR(0) <= SYNTHESIZED_WIRE_1 OR SYNTHESIZED_WIRE_2;


SYNTHESIZED_WIRE_0 <= NOT(SW(1));



SYNTHESIZED_WIRE_3 <= NOT(SW(3));



SYNTHESIZED_WIRE_4 <= SW(4) OR SYNTHESIZED_WIRE_3;


LEDR(1) <= SYNTHESIZED_WIRE_4 AND SW(5);


END bdf_type;