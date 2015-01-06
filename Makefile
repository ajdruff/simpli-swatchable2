#
# BUILD SWATCHES
#


swatches: 
	@./make-bootswatches.sh

default: 
	@./make-bootswatches.sh

.PHONY: swatches default