# Default targets
.PHONY: default start stop clean
default: usage

# Makefile setup
SHELL:=/bin/bash
RT_KERNEL := $(shell uname -r | grep -i 'rt')

# Help
usage:
	@echo "make TARGET"
	@echo "   TARGETS: "
	@echo "     usage: Help message"
	@echo ""

# Targets
install:
	@if [[ "$(RT_KERNEL)" != "" ]] ; then \
		echo "OS is running a realtime kernel" ; \
		sudo apt install rt-tests ; \
	else \
		echo "OS is NOT running a realtime kernel" ; \
		sudo apt install linux-image-rt ; \
		echo "Please reboot if the kernel was installed" ; \
	fi

test:
	@echo "### Prio 10 ########################"
	@sudo cyclictest -t 1 -p 10 -i 1000 -l 10000
	@echo "### Prio 20 ########################"
	@sudo cyclictest -t 1 -p 20 -i 1000 -l 10000
	@echo "### Prio 30 ########################"
	@sudo cyclictest -t 1 -p 30 -i 1000 -l 10000
	@echo "### Prio 99 ########################"
	@sudo cyclictest -t 1 -p 99 -i 1000 -l 10000
