FROM debian:9

RUN apt-get update && \
	DEBIAN_FRONTEND=noninteractive apt-get install -y lxde tightvncserver nano vim curl && \
	apt-get clean && rm -rf /var/lib/apt/lists/*

ENV USER=root
USER root

COPY home/root/.vnc /root/.vnc
COPY entrypoint.sh /usr/bin/entrypoint.sh
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["/usr/bin/entrypoint.sh"]
CMD exec bash -c "vncserver :1 -geometry 1280x800 -depth 24 && tail -F /root/.vnc/*.log"
EXPOSE 5901