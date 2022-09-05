FROM oraclelinux:8

RUN dnf update -y && \
	dnf install -y bind bind-utils oracle-epel-release-el8 && \
	dnf install -y supervisor vim ruby tcpdump && \
	dnf clean all

RUN dnf update -y && \
	dnf install -y ca-certificates && \
	dnf install -y https://www.ngtech.co.il/repo/oracle/8/x86_64/squid-5.6-1.el8.x86_64.rpm https://www.ngtech.co.il/repo/oracle/8/x86_64/squid-helpers-5.6-1.el8.x86_64.rpm && \
	dnf clean all

COPY supervisord.conf /etc/supervisord.conf
COPY start-squid.sh /start-squid.sh
COPY squid.conf /etc/squid/squid.conf

EXPOSE 3128

CMD ["/usr/bin/supervisord"]

