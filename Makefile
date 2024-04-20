main:
		iverilog -o out program_counter.v counter_column.v add_memory_address.v memory.v control_unit.v RegisterSet2.v alu.v processor.v processor_tb.v
		# iverilog -o out control_unit.v control_unit_tb.v
		# iverilog -o out program_counter.v program_counter_tb.v
		# iverilog -o out counter_column.v add_memory_address.v memory.v control_unit.v RegisterSet2.v alu.v processor.v processor_tb.v
		# iverilog -o out alu.v alu_tb.v
		# iverilog -o out add_memory_address.v add_memory_address_TB.v
		# iverilog -o out counter_column.v counter_column_TB.v
		# iverilog -o out memory.v control_unit.v RegisterSet.v alu.v processor.v processor_tb.v
		# iverilog -o out RegisterSet2.v RegisterSet2_TB.v
		# iverilog -o out RegisterSetV.v RegisterSetV_TB.v
		# iverilog -o out control_unit.v RegisterSet.v alu.v processor.v processor_tb.v
		# iverilog -o out RegisterSet.v control_unit.v alu.v processor.v processor_tb.v
		# iverilog -o out RegisterSet.v RegisterSet_TB.v
		# iverilog -o out add_bit.v add_4bit.v add_4bit_tb.v
		vvp out