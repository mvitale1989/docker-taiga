FROM python:3.5-stretch
MAINTAINER Benjamin Hutchins <ben@hutchins.co>

### Taiga configuration variables
ENV \
  TAIGA_HOSTNAME="localhost" \
  TAIGA_DB_NAME="" \
  TAIGA_DB_HOST="" \
  TAIGA_DB_USER="" \
  TAIGA_DB_PASSWORD="" \
  TAIGA_SSL="False" \
  TAIGA_SSL_BY_REVERSE_PROXY="False" \
  TAIGA_SECRET_KEY="!!!REPLACE-ME-j1598u1J^U*(y251u98u51u5981urf98u2o5uvoiiuzhlit3)!!!" \
  TAIGA_ENABLE_EMAIL="False" \
  TAIGA_EMAIL_FROM="" \
  TAIGA_EMAIL_USE_TLS="True" \
  TAIGA_EMAIL_HOST="" \
  TAIGA_EMAIL_PORT="" \
  TAIGA_EMAIL_USER="" \
  TAIGA_EMAIL_PASS="" \
  TAIGA_SKIP_DB_CHECK="" \
  TAIGA_DB_CHECK_ONLY="" \
  TAIGA_SLEEP="0"
 
### Setup system
COPY taiga-back /usr/src/taiga-back
COPY taiga-front-dist/ /usr/src/taiga-front-dist
COPY scripts /opt/taiga-bin
COPY conf /opt/taiga-conf
WORKDIR /usr/src/taiga-back
RUN /opt/taiga-bin/docker-install.sh system
RUN /opt/taiga-bin/docker-install.sh python
RUN /opt/taiga-bin/docker-install.sh configuration

### Container configuration
EXPOSE 80 443
VOLUME /usr/src/taiga-back/media
ENTRYPOINT ["/opt/taiga-bin/docker-entrypoint.sh"]
CMD ["python", "manage.py", "runserver", "0.0.0.0:8000"]
