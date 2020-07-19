FROM rocker/verse:4.0.2

ARG CTAN_REPO=${CTAN_REPO:-https://www.texlive.info/tlnet-archive/2019/02/27/tlnet}
ENV CTAN_REPO=${CTAN_REPO}

ENV PATH=$PATH:/opt/TinyTeX/bin/x86_64-linux/

RUN apt-get update \
    && apt-get install -y python3 python3-pip imagemagick libmagick-dev xvfb\
    && pip3 install Pygments \
    && tlmgr update --self \
    && tlmgr update --all \
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
    && install2.r --error magick \
    && wget -nv -O- https://download.calibre-ebook.com/linux-installer.sh | sh /dev/stdin
