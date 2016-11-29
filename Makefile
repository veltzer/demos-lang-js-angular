##########
# params #
##########
DO_MKDBG?=0
ALL:=
OUT:=out
HTML_SRC:=$(shell find src -name "*.html")
HTML_STAMP:=$(OUT)/html.stamp
TIDY:=tools/tidy-html5/bin/tidy
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
	@true

.PHONY: debug
debug:
	$(info HTML_SRC is $(HTML_SRC))
	$(info HTML_STAMP is $(HTML_STAMP))
	$(info ALL is $(ALL))

$(TOOLS_STAMP): templardefs/deps.py package.json
	$(info doing [$@])
	$(Q)templar install_deps
	$(Q)make_helper touch-mkdir $@

$(HTML_STAMP): $(HTML_SRC) support/tidy.conf $(TOOLS_STAMP) $(ALL_DEP)
	$(info doing [$@])
	$(Q)make_helper wrapper-silent node_modules/htmlhint/bin/htmlhint $(HTML_SRC)
	$(Q)make_helper touch-mkdir $@
#$(Q)$(TIDY) -config support/tidy.conf $(HTML_SRC)

.PHONY: clean
clean:
	$(info doing [$@])
	$(Q)git clean -xdf > /dev/null
