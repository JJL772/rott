#!/bin/sh
TOP=$(cd $(dirname $0);pwd);
cd "$TOP/../"

files=`find "./rott" -iname "*.c" -o -iname "*.cpp" -o -iname "*.cc" -o -iname "*.h"`
for file in $files; do
	clang-format -i $file
done
