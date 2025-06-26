#!/bin/bash

rm -f logs/*.log
# Path to test list and logs
REGRESS_FILE="regressions/regress_list.txt"
LOG_DIR="logs"
mkdir -p "$LOG_DIR"

# Clean previous logs (optional)
# rm -f $LOG_DIR/*.log

i=1
while IFS= read -r line || [[ -n "$line" ]]; do
  eval "$line"  # sets TESTNAME
  SEED=$(( RANDOM * RANDOM ))

  echo "[$i] Running $TESTNAME with SEED=$SEED"

  make clean > /dev/null
  make comp > "$LOG_DIR/comp_${TESTNAME}_${SEED}.log"
  make run TESTNAME=$TESTNAME \
    UVM_ARGS="+UVM_TESTNAME=$TESTNAME +sv_seed=$SEED +UVM_MAX_QUIT_COUNT=1 +access +rw -f messages.f" \
    > "$LOG_DIR/sim_${TESTNAME}_${SEED}.log"

  ((i++))
done < "$REGRESS_FILE"

# ADD THIS BLOCK AT THE END
echo "==== REGRESSION ERROR SUMMARY ====" > logs/summary.log

for logfile in logs/sim_*.log; do
  errors=$(awk '/UVM_ERROR/ { e=$NF } END { print e+0 }' "$logfile")
  fatals=$(awk '/UVM_FATAL/ { f=$NF } END { print f+0 }' "$logfile")

  total=$((errors + fatals))

  echo "$(basename "$logfile"): Errors=$errors, Fatals=$fatals" >> logs/summary.log
done

cat logs/summary.log
