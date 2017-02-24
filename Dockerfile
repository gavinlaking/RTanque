# RTanque
#
# Download the repo:
#
#     git clone https://github.com/gavinlaking/RTanque.git
#     cd RTanque/
#     git checkout upgrade_gosu
#
# Get setup with this line:
#
#     sudo docker build -t rtanque/my-first-tank .
#
# Start the container and begin dev
#
#     sudo docker run -it \
#       --net host \
#       --cpuset-cpus 0 \
#       --memory 512mb \
#       -v /tmp/.X11-unix:/tmp/.X11-unix \
#       -e DISPLAY=unix$DISPLAY \
#       --device /dev/snd \
#       -v $PWD:/home/development/RTanque:rw \
#       -v ~/Docker/:/home/development/docker:rw \
#       rtanque/my-first-tank /bin/bash
#
# Create your bot:
#
# bundle exec rtanque new_bot my_deadly_bot
#
# Make it FIGHT:
#
# bundle exec rtanque start bots/my_deadly_bot sample_bots/keyboard sample_bots/camper:x2
#
#
# Have fun!

FROM ubuntu

RUN apt-get update -y
RUN apt-get install -y build-essential git libsdl2-dev libsdl2-ttf-dev libpango1.0-dev libgl1-mesa-dev libopenal-dev libsndfile-dev ruby-dev freeglut3-dev

RUN usr/sbin/useradd --create-home --home-dir /home/development --shell /bin/bash development
RUN chown -R development:development /home/development
WORKDIR /home/development/

RUN echo "---\n:benchmark: false\n:bulk_threshold: 1000\n:backtrace: false\n:verbose: true\ngem: --no-ri --no-rdoc" >> $HOME/.gemrc

ADD . /home/development/RTanque
WORKDIR /home/development/RTanque
RUN gem install bundler
RUN bundle install
RUN chown -R development:development .
USER development
