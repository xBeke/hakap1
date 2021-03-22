FROM ubuntu:latest

RUN apt-get update && apt-get -y install cowsay

ENV PATH="/usr/games/:${PATH}"

ADD cowsay7.d/start_cowsay.sh /root/start_cowsay.sh
ADD cowsay7.d/sentences.log /root/sentences.log

ENV WAITFILE_SENTENCE="I don't know what to say..."
ENV BAILOUT_SENTENCE="Too late. See you next time!"
ENV FNAME="/root/sentences.log"
ENV SLEEP="1"

CMD ["/bin/bash", "/root/start_cowsay.sh"]
