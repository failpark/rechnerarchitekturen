#!/bin/bash

find L* -type f | while IFS= read -r file; do
	./bootstrap.sh "$file" < /dev/tty
done