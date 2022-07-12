FROM rocker/verse:4.2.0

ARG CTAN_REPO=${CTAN_REPO:-https://www.texlive.info/tlnet-archive/2022/07/11/tlnet}
ENV CTAN_REPO=${CTAN_REPO}

ENV PATH=$PATH:/opt/TinyTeX/bin/x86_64-linux/

COPY scripts/install_pandoc_latest.sh rocker_scripts

RUN apt-get update \
    && apt-get install -y apt-utils \
    && apt-get install -y python3 python3-pip xvfb \
    && apt-get install -y libmagick++-dev \
    && apt-get install -y imagemagick \
    && apt-get install -y qpdf \
    && apt-get install -y libnetcdf-dev \
    && apt-get install -y libproj-dev \
    && apt-get install -y libgeos-dev \
    && apt-get install -y libgdal-dev \
    && apt-get install -y libudunits2-dev \
    && install2.r -e Rcpp \
    && install2.r -e -s magick \
    && install2.r -e -s pkgdown \
    && install2.r -e -s ncdf4 \
    && install2.r -e -s raster \
    && install2.r -e -s units \
    && install2.r -e -s sf \
    && install2.r -e -s lwgeom \
    && install2.r -e -s janitor \
    && install2.r -e -s tsibble \
    && install2.r -e -s slider \
    && install2.r -e -s stars \
    && install2.r -e -s RNetCDF \
    && install2.r -e -s tidync \
    && pip3 install Pygments \
    && tlmgr update --self \
    && tlmgr update --all \
    && tlmgr install cm-super ec lm \
    && tlmgr install minted \
    && tlmgr install amsmath \
    && tlmgr install hyperref url \
    && tlmgr install unicode-math upquote microtype xcolor \
    && tlmgr install booktabs mhchem xurl \
    && tlmgr install etoolbox footnotehyper \
    && tlmgr install caption bookmark \
    && tlmgr install kvoptions pdftexcmds infwarerr \
    && tlmgr install grffile fvextra fancyvrb lineno ifplatform catchfile \
    && tlmgr install catchfile xstring framed float epstopdf-pkg \
    && tlmgr install relsize ebgaramond-maths newtx fontspec \
    && tlmgr install tufte-latex \
    && tlmgr install hardwrap titlesec ragged2e ms geometry textcase \
    && tlmgr install setspace natbib ec fancyhdr units ulem morefloats \
    && tlmgr install subfig \
    && tlmgr install bera \
    && tlmgr install mathpazo soul \
    && wget -nv -O- https://download.calibre-ebook.com/linux-installer.sh | sh /dev/stdin \
    && rocker_scripts/install_pandoc_latest.sh \
    && Rscript -e "remotes::install_github('jonathan-g/blogdownDigest')"
