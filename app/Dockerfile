FROM amazonlinux

WORKDIR C:/Users/br4am/sisprog/app/

RUN cd /home && mkdir Documents && mkdir Pictures \
&& mkdir Music && mkdir Downloads && mkdir Videos

COPY script.sh /home/Documents

COPY 1.PNG /home/Pictures

COPY 2.PNG /home/Pictures

RUN cd /home/Documents && chmod +x script.sh