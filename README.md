![build workflow](https://github.com/sib-swiss/intro-spatial-transcriptomics-training/actions/workflows/docker-image.yml/badge.svg)
![GitHub Release Date](https://img.shields.io/github/release-date/sib-swiss/intro-spatial-transcriptomics-training)
[![License: CC BY-SA 4.0](https://img.shields.io/badge/License-CC_BY--SA_4.0-lightgrey.svg)](https://creativecommons.org/licenses/by-sa/4.0/)

This website is hosted at: https://sib-swiss.github.io/intro-spatial-transcriptomics-training

Please refer to [issues](https://github.com/sib-swiss/intro-spatial-transcriptomics-training/issues) for improvements/bugs for course material or the website. 

Any contribution to this course material is highly appreciated :+1:. Please have a look at the [CONTRIBUTING.md](CONTRIBUTING.md) file to learn more on how to contribute. 

## Authors

- Deepak Tanwar [ORCiD](https://orcid.org/0000-0001-8036-1989)
- Joana Carlevaro-Fita [ORCiD](https://orcid.org/0000-0002-1674-2055)
- Geert van Geest [ORCiD](https://orcid.org/0000-0002-1561-078X)
- Julien Roux [ORCiD](https://orcid.org/0000-0002-4192-5099)
- Martin Emons [ORCiD](https://orcid.org/0009-0000-5219-5311)
- Peiying Cai [ORCiD](https://orcid.org/0009-0001-9229-2244)
- Ivan Berest [ORCiD](https://orcid.org/0000-0001-7607-9163)
- Mark Robinson [ORCiD](https://orcid.org/0000-0002-3048-5518)

## Local Development

This website is generated with [quarto](https://quarto.org/). To contribute or run the material locally, you will need to have [R](https://www.r-project.org/) and [Quarto CLI](https://quarto.org/docs/get-started/) installed.

1. **Clone the repository:**
   ```sh
   git clone https://github.com/sib-swiss/intro-spatial-transcriptomics-training.git
   cd intro-spatial-transcriptomics-training
   ```

2. **Install R packages:** This project uses `renv` to manage R dependencies. To install the required packages, open R and run:
   ```R
   install.packages("renv")
   renv::restore()
   ```

3. **Render the site:** To build the website, run the following command in the terminal:
   ```sh
   quarto render
   ```
   This will generate the website in the `_site` directory.

4. **Preview the site:** To preview the website as you make changes, you can use:
   ```sh
   quarto preview
   ```

### Publishing

To publish the website to GitHub Pages, use the following command:

```sh
quarto publish gh-pages
```

This will render the site and push the `_site` directory to the `gh-pages` branch. Make sure you have the necessary permissions to push to the repository.

## Docker

For a reproducible environment, you can use the provided Docker setup. A pre-built Docker image is available on [Docker Hub](https://hub.docker.com/r/sibswiss/training-seq-spatial-transcriptomics-rstudio).

1. **Pull the Docker image:**
   ```sh
   docker pull sibswiss/training-intro-spatial-transcriptomics-rstudio:latest
   ```

2. **Run the Docker container:** Navigate to the `Docker` directory and use the provided script to run the container:
   ```sh
   cd Docker
   ./run_locally.sh
   ```
   Alternatively, you can run the container manually from the project root directory:
   ```sh
   docker run --rm -p 8787:8787 -v $PWD:/home/rstudio sibswiss/training-intro-spatial-transcriptomics-rstudio:latest
   ```
   This will start an RStudio server on http://localhost:8787. The `-v $PWD:/home/rstudio` command mounts the current directory into the container, so you can edit the files locally and see the changes reflected in the container.
