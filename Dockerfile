FROM haskell:8.0

MAINTAINER Lars Bättig <me@l4rs.net>

# install latex packages
RUN apt-get update -y \
  && apt-get install -y -o Acquire::Retries=10 --no-install-recommends \
    texlive-latex-base \
    texlive-xetex latex-xcolor \
    texlive-math-extra \
    texlive-latex-extra \
    texlive-fonts-extra \
    texlive-bibtex-extra \
    fontconfig \
    lmodern \
    unzip \
    curl \
    poppler-utils

RUN apt-get install -y texlive-lang-german
# will ease up the update process
# updating this env variable will trigger the automatic build of the Docker image
ENV PANDOC_VERSION "2.2"

# install pandoc
RUN cabal update && cabal install pandoc-${PANDOC_VERSION}
#RUN apt-get install -y texlive-generic-recommended

# install eisvogel template
RUN mkdir -p /root/.pandoc/templates
RUN curl -o /root/.pandoc/templates/eisvogel.latex https://raw.githubusercontent.com/l4r-s/pandoc-latex-template/master/eisvogel.tex 

WORKDIR /source

