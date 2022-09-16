# pygbag

python wasm for everyone ( packager + test server )

runs python code directly in modern web browsers, including mobile versions.



"your.app.folder" must contains a main.py and its loop must be async aware eg :

```py
import asyncio

# try explicity to declare all your globals at once
# to faciliate compilation later
COUNT_DOWN = 3

# do init here, and load any assets right now to avoid lag
# at runtime or network errors.




async def main():
    global COUNT_DOWN

    COUNT_DOWN = 3

    while True:

        # do your rendering here, note that it is NOT an infinite loop
        # and it fired only when VSYNC occurs
        # usually 1/60 or more times per seconds on dekstop, maybe less
        # on some mobile devices

        print(f"""

        Hello[{count}] from Python

""")

        await asyncio.sleep(0)  # very important, and keep it 0

        if not COUNT_DOWN:
            return

        COUNT_DOWN = COUNT_DOWN - 1

# this is the program entry point.
asyncio.run(main())

# do not add anything from here
# asyncio.run is non blocking on pygame-wasm
```

usage:

    pip3 install pygbag --user --upgrade
    pygbag your.app.folder

command help:

    pygbag --help your.app.folder


example :

```
user@pp /data/git/pygbag $ python3 -m pygbag --help test
 *pygbag 0.4.0*

Serving python files from [/data/git/pygbag/test/build/web]

with no security/performance in mind, i'm just a test tool : don't rely on me
usage: __main__.py [-h] [--bind ADDRESS] [--directory DIRECTORY]
 [--PYBUILD PYBUILD] [--app_name APP_NAME] [--ume_block UME_BLOCK]
 [--can_close CAN_CLOSE] [--cache CACHE] [--package PACKAGE] [--title TITLE]
 [--version VERSION] [--build] [--html] [--no_opt] [--archive] [--icon ICON]
 [--cdn CDN] [--template TEMPLATE] [--ssl SSL] [--port [PORT]]

options:
  -h, --help            show this help message and exit
  --bind ADDRESS        Specify alternate bind address [default: localhost]
  --directory DIRECTORY
                        Specify alternative directory [default:/data/git/pygbag/test/build/web]
  --PYBUILD PYBUILD     Specify python version [default:3.11]
  --app_name APP_NAME   Specify user facing name of application [default:test]
  --ume_block UME_BLOCK
                        Specify wait for user media engagement before running [default:1]
  --can_close CAN_CLOSE
                        Specify if window will ask confirmation for closing [default:0]
  --cache CACHE         md5 based url cache directory
  --package PACKAGE     package name, better make it unique
  --title TITLE         App nice looking name
  --version VERSION     override prebuilt version path [default:0.4.0]
  --build               build only, do not run test server
  --html                build as html with embedded assets (pygame-script)
  --no_opt              turn off assets optimizer
  --archive             make build/web.zip archive for itch.io
  --icon ICON           icon png file 32x32 min should be favicon.png
  --cdn CDN             web site to cache locally [default:https://pygame-web.github.io/archives/0.4/]
  --template TEMPLATE   index.html template [default:default.tmpl]
  --ssl SSL             enable ssl with server.pem and key.pem
  --port [PORT]         Specify alternate port [default: 8000]
```

Now navigate to http://localhost:8000 with a modern Browser.

use http://localhost:8000#debug for getting a terminal and a sized down canvas

for pygame-script go to http://localhost:8000/your.app.folder.html



v8 based browsers are preferred ( chromium/brave/chrome ... )
starting with 81.0.4044 ( android 4.4 ).
Because they set baseline restrictions on WebAssembly loading.
Using them while testing ensure proper operation on all browsers.


NOTES:

 - first load will be slower, because setting up local cache from cdn to avoid
useless network transfer for getting pygame and cpython prebuilts.

 - each time changing code/template you must restart `pygbag your.app.folder`
   but cache is not destroyed.

 - if you want to reset prebuilts cache, remove the build/web-cache folder in
   your.app.folder


BUILDING:

pygbag is not only a python module, and rebuilding all the toolchain can be quite
hard

https://github.com/pygame-web/python-wasm-sdk  <= build CPython (not pyodide)


The default is to build only pygame, but feel free to fork and add yours

so read/use pygbag CI to see how to build pygame + the C loader (pymain) and
how it is linked it to libpython + libpygame

https://github.com/pygame-web/pygbag

default prebuilts (pygame) used by pygbag are stored on github
from the repo https://github.com/pygame-web/archives under versionned folders


ADDING STATIC MODULES:

    see in package.d directory and use vendor/vendor.sh


SUPPORT FOR STATIC MODULES :

    see in package.d/<vendor>/README.md for module <vendor> specific support

GENERIC PYGBAG SUPPORT OR PYGAME MODULE:

[for generic help around pygbag](https://github.com/pygame-web/pygbag/blob/main/packages.d/pygame/README.md)





