FROM pataquets/tor

RUN \
  sed 's/HiddenServicePort 80 backend:80/HiddenServicePort 9091 backend:9091/g' \
    /etc/tor/conf-available/hidden-service/HiddenService-http \
    | tee /etc/tor/conf-available/hidden-service/HiddenService-transmission \
  && \
  sed 's/HiddenServicePort 80 backend:80/HiddenServicePort 80 backend:9091/g' \
    /etc/tor/conf-available/hidden-service/HiddenService-http \
    | tee /etc/tor/conf-available/hidden-service/HiddenService-transmission-http \
  && \
  sed 's/HiddenServicePort 80 backend:80/HiddenServicePort 443 backend:9091/g' \
    /etc/tor/conf-available/hidden-service/HiddenService-http \
    | tee /etc/tor/conf-available/hidden-service/HiddenService-transmission-https

RUN \
  cat \
    /etc/tor/conf-available/common/* \
    /etc/tor/conf-available/hidden-service/HiddenServiceDir \
    /etc/tor/conf-available/hidden-service/HiddenService-transmission \
    /etc/tor/conf-available/hidden-service/HiddenService-transmission-http \
    /etc/tor/conf-available/hidden-service/HiddenService-transmission-https \
  | tee -a /etc/tor/torrc \
  && \
  nl /etc/tor/torrc
