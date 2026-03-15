#!/bin/bash

FILE="data/samples.tsv"

if [ -f "$FILE" ]; then
  echo "Found $FILE"
  echo "Here are the first 3 lines:"
  head -n 3 "$FILE"
else
  echo "Could not find $FILE"
fi
