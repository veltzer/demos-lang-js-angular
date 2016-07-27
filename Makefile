##########
# params #
##########
DO_MKDBG?=0
ALL:=
OUT:=out
HTML_SRC:=$(shell find src -name "*.html")
HTML_STAMP:=$(OUT)/html.stamp
TIDY:=~/install/tidy-html5/bin/tidy
ALL+=$(HTML_STAMP)

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
all: $(ALL)

debug:
	$(info HTML_SRC is $(HTML_SRC))
	$(info HTML_STAMP is $(HTML_STAMP))
	$(info ALL is $(ALL))

$(HTML_STAMP): $(HTML_SRC)
	$(info doing [$@])
	$(Q)$(TIDY) -errors -q $(HTML_SRC)
	$(Q)make_helper touch-mkdir $@
