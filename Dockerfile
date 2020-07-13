FROM rocker/verse:4.0.2

ARG CTAN_REPO=${CTAN_REPO:-https://www.texlive.info/tlnet-archive/2019/02/27/tlnet}
ENV CTAN_REPO=${CTAN_REPO}

ENV PATH=$PATH:/opt/TinyTeX/bin/x86_64-linux/

RUN apt-get update \
    && apt-get install -y python3 python3-pip imagemagick libmagick-dev xvfb\
    && pip3 install Pygments \
    && tlmgr update --self \
    && tlmgr update --all \
    && tlmgr install minted amsmath latex-amsmath-dev iftex kvoptions ltxcmds kvsetkeys \
       etoolbox xcolor atbegshi atveryend auxhook bigintcalc bitset etexcmds gettitlestring \
       hycolor hyperref intcalc kbdefinekeys letltxmacro pdfescape refcount rerunfilecheck \
       stringenc uniquecounter zapfding pdfcmds infwarerr booktabs mdwtools griffile fvextra \
       fancyvrb upquote lineno ifplatform catchfile xstring framed float chemgreek mhchem \
       caption epstopdf \
    && install2.r --error magick \
    && wget -nv -O- https://download.calibre-ebook.com/linux-installer.sh | sh /dev/stdin

