all:
	echo "OK"
build:
	podman build -t $(shell cat dockerimage) .
run:
	podman run -d -p 8080:3128/tcp --name squid_cache  $(shell cat dockerimage)
#	podman run -d -p 8080:3128/tcp --volume /opt/src/squid-docker/squid.conf:/etc/squid/squid.conf --name squid_cache  $(shell cat dockerimage)

stop:
	podman stop squid_cache 
rm:
	podman rm squid_cache 


gen-systemd-service:
	podman generate systemd squid_cache > /etc/systemd/system/$(shell cat service_filename)
	systemctl daemon-reload

systemd-stop:
	systemctl stop $(shell cat service_filename)
systemd-start:
	systemctl start $(shell cat service_filename)
systemd-status:
	systemctl status $(shell cat service_filename)

systemd-restart:
	systemctl restart $(shell cat service_filename)

systemd-enable:
	systemctl enable $(shell cat service_filename)
