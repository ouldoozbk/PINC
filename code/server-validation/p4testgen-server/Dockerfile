# Use amd64 so this works on Apple Silicon (p4lang/p4c has no arm64 image)
FROM --platform=linux/amd64 p4lang/p4c

RUN apt update && apt install -y nano

RUN apt install -y git cmake g++ pkg-config libboost-all-dev \
  libfl-dev bison flex libgmp-dev libgc-dev python3 python3-pip nano

RUN pip3 uninstall -y protobuf googleapis-common-protos

RUN pip3 install --no-cache-dir protobuf==3.20.3 googleapis-common-protos uvicorn[standard] fastapi pydantic

WORKDIR /root

RUN git clone https://github.com/p4lang/p4c.git

RUN #apt update && apt install -y netcat
RUN apt update && apt install -y netcat inotify-tools

RUN mkdir -p /work_space

COPY run_tests.sh /work_space/run_tests.sh
COPY container_handler.py /work_space/container_handler.py

WORKDIR /work_space

RUN chmod +x run_tests.sh

EXPOSE 8000

ENTRYPOINT ["uvicorn", "container_handler:app"]
CMD ["--host", "0.0.0.0", "--port", "8000"]


#
# build using:
#docker buildx build --tag p4_test_suite . --load
# OR: docker build -t p4_test_suite .
#
# run:
# docker run --rm --privileged --cap-add=NET_ADMIN --network=host -v $(pwd):/temporary p4_test_suite /temporary/ref.p4
# docker run -d --privileged --cap-add=NET_ADMIN -p 8001:8000 --name p4_worker_1  p4_test_suite
#
# docker run --rm -it   --privileged --cap-add=NET_ADMIN --network=host --entrypoint /bin/bash  p4_test_suite