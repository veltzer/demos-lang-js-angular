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
endif # DO_ALLDEP

ALL+=$(HTML_STAMP)

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

$(HTML_STAMP): $(HTML_SRC) support/tidy.conf
	$(info doing [$@])
	$(Q)pymakehelper only_print_on_error node_modules/.bin/htmlhint $(HTML_SRC)
	$(Q)pymakehelper touch_mkdir $@
#$(Q)$(TIDY) -config support/tidy.conf $(HTML_SRC)

.PHONY: clean
clean:
	$(Q)rm -f $(ALL)

.PHONY: clean_hard
clean_hard:
	$(info doing [$@])
	$(Q)git clean -qffxd
