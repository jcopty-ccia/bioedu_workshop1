#!/bin/bash

COUNT=1

while [ "$COUNT" -le 3 ]
do
  echo "Loop iteration $COUNT"
  COUNT=$((COUNT + 1))
done

echo "Now reading sample names from data/samples.tsv"

tail -n +2 data/samples.tsv | while IFS=$'\t' read -r sample project status runtime
do
  echo "Sample: $sample | Project: $project | Status: $status | Runtime: $runtime"
done
