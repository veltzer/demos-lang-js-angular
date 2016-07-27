##########
# params #
##########
DO_MKDBG?=0
ALL:=
OUT:=out
HTML_SRC:=$(shell find src -name "*.html")
HTML_STAMP:=$(OUT)/html.stamp
TIDY:=~/install/tidy-html5/bin/tidy
TOOLS_STAMP:=$(OUT)/tools.stamp
ALL+=$(HTML_STAMP)
ALL_DEP:=Makefile

########
# code #
########

ifeq ($(DO_MKDBG),1)
Q=
# we are not silent in this branch
else # DO_MKDBG
Q=@
#.SILENT:
endif # DO_MKDBG

#########
# rules #
#########
.PHONY: all
all: $(ALL) $(ALL_DEP)

.PHONY: debug
debug:
	$(info HTML_SRC is $(HTML_SRC))
	$(info HTML_STAMP is $(HTML_STAMP))
	$(info ALL is $(ALL))

$(TOOLS_STAMP): scripts/tools.py $(ALL_DEP)
	$(info doing [$@])
	$(Q)$<
	$(Q)make_helper touch-mkdir $@

$(HTML_STAMP): $(HTML_SRC) $(TOOLS_STAMP) $(ALL_DEP)
	$(info doing [$@])
	$(Q)$(TIDY) -errors -q $(HTML_SRC)
	$(Q)node_modules/htmlhint/bin/htmlhint $(HTML_SRC) > /dev/null
	$(Q)make_helper touch-mkdir $@

.PHONY: clean
clean:
	$(info doing [$@])
	$(Q)git clean -xdf > /dev/null
