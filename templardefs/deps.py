'''
dependencies for this project
'''

def populate(d):
    d.tools=[
        #'tidy-html5',
    ]
    d.packs=[
        # for jslint
        'nodejs',
        # for jslint
        'npm',
    ]

def get_deps():
    return [
        __file__, # myself
    ]
