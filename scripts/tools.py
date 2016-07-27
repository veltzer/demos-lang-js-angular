#!/usr/bin/python3

'''
this script will install all the required packages that you need
to compile and work with this package.
'''

###########
# imports #
###########
import subprocess # for check_call, DEVNULL
import os.path # for isfile
import sys # for path
import os # for cwd mkdir, chmod, listdir
import shutil # for rmtree
import urllib.request # for urlretrieve

##############
# parameters #
##############
tp='out/web/thirdparty'
tools='tools'
debug=False
quiet=True
packs=[
	# nodejs and npm for installing javascript packages
	'nodejs',
	'npm',
	# my own
	'templar',
]

#############
# functions #
#############
def msg(m):
	if not quiet:
		print(msg)

########
# code #
########
for pack in packs:
	msg('getting ubuntu package for [{0}]'.format(pack))
	subprocess.check_call([
		'sudo',
		'apt-get',
		'install',
		'--assume-yes',
		pack
	], stdout=subprocess.DEVNULL, stderr=subprocess.DEVNULL)

msg('installing node packages...')
subprocess.check_call([
	'npm',
	'install',
], stdout=subprocess.DEVNULL, stderr=subprocess.DEVNULL)
