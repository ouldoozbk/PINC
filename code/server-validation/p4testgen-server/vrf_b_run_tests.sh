#!/bin/bash
P4FILE=${1:-demo1.p4_16.p4}
BASENAME=$(basename "$P4FILE" .p4)

for i in $(seq 0 2 14); do
  j=$((i+1))

  # delete any leftover from a previous run
  ip link delete veth$i 2>/dev/null || true
  ip link delete veth$j 2>/dev/null || true

  # now create fresh
  ip link add  veth$i  type veth peer name veth$j
  ip link set  veth$i  up
  ip link set  veth$j  up

  # disable IPv6 ND on each side
  echo 1 > /proc/sys/net/ipv6/conf/veth$i/disable_ipv6  2>/dev/null || true
  echo 1 > /proc/sys/net/ipv6/conf/veth$j/disable_ipv6  2>/dev/null || true

  # turn off all multicast reception
  ip link set dev veth$i allmulticast off 2>/dev/null || true
  ip link set dev veth$j allmulticast off 2>/dev/null || true
done

print_p4c_dir_message() {
    1>&2 echo "To run this script successfully, either:"
    1>&2 echo ""
    1>&2 echo "(a) Use the following commands to create a clone of the p4c repository there:"
    1>&2 echo "    cd `dirname $P4C_CLONE_DIR`"
    1>&2 echo "    git clone https://github.com/p4lang/p4c"
    1>&2 echo ""
    1>&2 echo "(b) Edit the script '$0' and change the definition"
    1>&2 echo "    of P4C_CLONE_DIR to be the path to a copy of the"
    1>&2 echo "    p4c repository that you have installed on your system."
}

P4C_CLONE_DIR="$HOME/p4c"
if [ ! -d ${P4C_CLONE_DIR} ]; then
    1>&2 echo "No such directory: $P4C_CLONE_DIR"
    1>&2 echo "Expected to find a clone of the repository there."
    print_p4c_dir_message
    exit 1
fi

BASE_TEST_DIR="$P4C_CLONE_DIR/tools/ptf"
if [ -r "${BASE_TEST_DIR}/base_test.py" ]; then
    echo "Found p4c base_test.py package: ${BASE_TEST_DIR}/base_test.py"
else
    1>&2 echo "Did not find p4c base_test.py package: ${BASE_TEST_DIR}/base_test.py"
    print_p4c_dir_message
fi

# Generate test cases using p4testgen
rm -rf out-p4testgen/*
echo "Running p4testgen on $P4FILE ..."
p4testgen --target bmv2 --arch v1model --max-tests 10 --out-dir out-p4testgen --test-backend ptf "$P4FILE"

P4TESTGEN_OUTPUT_DIR="out-p4testgen"
# Patch all generated tests to comment out control-plane setup


if [ -d "${P4TESTGEN_OUTPUT_DIR}" ]; then
    echo "Test cases generated in: ${P4TESTGEN_OUTPUT_DIR}"
else
    echo "Error: Test generation failed. Directory ${P4TESTGEN_OUTPUT_DIR} not found."
    exit 1
fi


T="`realpath ${BASE_TEST_DIR}`"
if [ x"${PYTHONPATH}" == "x" ]
then
    P="${T}"
else
    P="${T}:${PYTHONPATH}"
fi

set -x
p4c --target bmv2 \
    --arch v1model \
    --p4runtime-files "${BASENAME}.p4info.txtpb" \
        "$P4FILE"


# Remove any log file written in an earlier run, otherwise
# simple_switch_grpc will append the new log messages to the end of
# the existing file.
/bin/rm -f ss-log.txt

simple_switch_grpc \
     --log-file ss-log \
     --log-flush \
     --dump-packet-data 10000 \
     -i 0@veth0 \
     -i 1@veth2 \
     -i 2@veth4 \
     -i 3@veth6 \
     -i 4@veth8 \
     -i 5@veth10 \
     -i 6@veth12 \
     -i 7@veth14 \
     --no-p4 &
echo ""
echo "Started simple_switch_grpc.  Waiting 2 seconds before starting PTF test ..."
#sleep 2

for i in {1..20}; do
    if nc -z localhost 9559; then
        echo "simple_switch_grpc is ready"
        break
    fi
    sleep 0.1
done

# Note that the mapping between switch port number and Linux interface
# names is best to make it correspond with those given when starting
# the simple_switch_grpc process.  The `ptf` process has no other way
# of getting this mapping other than by telling it on its command
# line.

${P4_EXTRA_SUDO_OPTS} `which ptf` \
    --pypath "$P" \
    -i 0@veth1 \
    -i 1@veth3 \
    -i 2@veth5 \
    -i 3@veth7 \
    -i 4@veth9 \
    -i 5@veth11 \
    -i 6@veth13 \
    -i 7@veth15 \
    --test-params="grpcaddr='localhost:9559';p4info='${BASENAME}.p4info.txtpb';config='${BASENAME}.json'" \
    --test-dir out-p4testgen

echo ""
echo "PTF test finished.  Waiting 2 seconds before killing simple_switch_grpc ..."
#sleep 2
pkill --signal 9 --list-name simple_switch
echo ""
echo "Verifying that there are no simple_switch_grpc processes running any longer in 4 seconds ..."
#sleep 4

for i in {1..20}; do
    if ! pgrep -f simple_switch_grpc > /dev/null; then
        echo "simple_switch_grpc terminated"
        break
    fi
    sleep 0.1
done

ps axguwww | grep simple_switch

