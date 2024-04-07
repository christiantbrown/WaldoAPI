FROM ubuntu:20.04

RUN apt update && apt install -y cmake g++ wget unzip

COPY . .

RUN g++ waldo.cpp -o waldo

ENV PORT=8080

EXPOSE 8080

CMD [ "./waldo" ]

