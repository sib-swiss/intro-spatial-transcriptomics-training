FROM rocker/rstudio:4.5.3

# Script for to set up multiple users
# COPY batch_user_creation.sh /rocker_scripts/experimental/batch_user_creation.sh

# CMD [ "sh", "-c", "/rocker_scripts/experimental/batch_user_creation.sh && /init" ]

# Install system dependencies required for R packages
RUN apt-get update && apt-get install -y \
    build-essential \
    git \
    openssh-client \
    libxt6 \
    libgl1 \
    libcurl4-openssl-dev \
    libssl-dev \
    libxml2-dev \
    libglpk-dev \
    libproj-dev \
    libudunits2-dev \
    libgdal-dev \
    libgeos-dev \
    libspatialite-dev \
    libcairo2-dev \
    libxt-dev \
    libmagick++-dev \
    libharfbuzz-dev \
    libfribidi-dev \
    libtiff5-dev \
    libpng-dev \
    libjpeg-dev \
    libicu-dev \
    tree \
    cmake \
    gdal-bin \
    fonts-dejavu \
    fontconfig \
    && rm -rf /var/lib/apt/lists/*


COPY renv.lock ./

ENV RENV_INSTALL_THREADS=8

RUN Rscript -e 'install.packages("renv", version = "1.1.8", repos="https://cloud.r-project.org", type="source")'

#RUN Rscript -e 'renv::restore()'
