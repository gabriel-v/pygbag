#!/bin/bash -ex

(
    mkdir -p /opt/python-wasm-sdk/prebuilt/emsdk/3.11/site-packages/lvgl
    echo " =================================================="
    echo "|"
    echo "v"
    env
    echo "^"
    echo "|"
    echo " =================================================="
    echo "building lvgl...."
    cd "$(dirname ${BASH_SOURCE[0]})"
    cd pygame-lvgl-wasm

    . /opt/python-wasm-sdk/wasm32-mvp-emscripten-shell.sh
    . ${SDKROOT}/emsdk/emsdk_env.sh
    export EMSDK_PYTHON=$SYS_PYTHON
    export EMCC_CFLAGS="$EMCC_CFLAGS -DHAVE_STDARG_PROTOTYPES -DBUILD_STATIC -ferror-limit=1 -fpic"
    export CC=emcc

    /opt/python-wasm-sdk/python3-wasm setup.py build -j8
    /opt/python-wasm-sdk/python3-wasm setup.py install

    OBJS=$(find build/temp.wasm32-*/|grep o$)
    $SDKROOT/emsdk/upstream/emscripten/emar cr ${SDKROOT}/prebuilt/emsdk/liblvgl${PYBUILD}.a $OBJS
)
