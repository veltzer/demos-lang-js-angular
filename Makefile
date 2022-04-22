##########
# params #
##########
# do you want dependency on the Makefile itself ?
DO_ALLDEP:=1
# do you want to see the commands?
DO_MKDBG?=0

########
# code #
########
ALL:=
OUT:=out
HTML_SRC:=$(shell find src -name "*.html")
HTML_STAMP:=$(OUT)/html.stamp
TIDY:=tools/tidy-html5/bin/tidy
TOOLS_STAMP:=$(OUT)/tools.stamp
ALL+=$(HTML_STAMP)

ifeq ($(DO_MKDBG),1)
Q=
# we are not silent in this branch
else # DO_MKDBG
Q=@
#.SILENT:
endif # DO_MKDBG

# dependency on the makefile itself
ifeq ($(DO_ALLDEP),1)
.EXTRA_PREREQS+=$(foreach mk, ${MAKEFILE_LIST},$(abspath ${mk}))
endif

#########
# rules #
#########
.PHONY: all
all: $(ALL)
	@true

.PHONY: debug
debug:
	$(info HTML_SRC is $(HTML_SRC))
	$(info HTML_STAMP is $(HTML_STAMP))
	$(info ALL is $(ALL))

$(TOOLS_STAMP): config/deps.py package.json
	$(info doing [$@])
	$(Q)pymakehelper touch_mkdir $@

$(HTML_STAMP): $(HTML_SRC) support/tidy.conf $(TOOLS_STAMP)
	$(info doing [$@])
	$(Q)pymakehelper only_print_on_error node_modules/htmlhint/bin/htmlhint $(HTML_SRC)
	$(Q)pymakehelper touch_mkdir $@
#$(Q)$(TIDY) -config support/tidy.conf $(HTML_SRC)

.PHONY: clean
clean:
	$(info doing [$@])
	$(Q)git clean -qffxd
