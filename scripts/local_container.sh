docker run \
-p 8787:8787 \
--rm \
--name rstudio_admin \
-e PASSWORD=test123 \
-v $PWD:/home/rstudio \
training-intro-spatial-transcriptomics-rstudio:latest
