# Default targets
.PHONY: default start stop clean
default: usage

POLICY:=rr
INTERVAL:=1000
ITERATIONS:=10000
THREADS:=1
CLOCK_RT:=1

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
	@echo "### Prio 0 ########################"
	@sudo cyclictest -c $(CLOCK_RT) -t $(THREADS) \
		--priority=0 --policy=$(POLICY) -i $(INTERVAL) -l $(ITERATIONS)
	@echo "### Prio 10 ########################"
	@sudo cyclictest -c $(CLOCK_RT) -t $(THREADS) \
		--priority=10 --policy=$(POLICY) -i $(INTERVAL) -l $(ITERATIONS)
	@echo "### Prio 20 ########################"
	@sudo cyclictest -c $(CLOCK_RT) -t $(THREADS) \
		--priority=20 --policy=$(POLICY) -i $(INTERVAL) -l $(ITERATIONS)
	@echo "### Prio 30 ########################"
	@sudo cyclictest -c $(CLOCK_RT) -t $(THREADS) \
		--priority=30 --policy=$(POLICY) -i $(INTERVAL) -l $(ITERATIONS)
	@echo "### Prio 99 ########################"
	@sudo cyclictest -c $(CLOCK_RT) -t $(THREADS) \
		--priority=99 --policy=$(POLICY) -i $(INTERVAL) -l $(ITERATIONS)
