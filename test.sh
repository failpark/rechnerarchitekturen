#!/bin/bash

find 0* -type f | while IFS= read -r file; do
	echo "$file"
	./bootstrap.sh "$file" < /dev/tty
done