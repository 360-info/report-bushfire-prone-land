# Bushfire Prone Land
### [📊&nbsp;Get&nbsp;the&nbsp;data](data) • [💻&nbsp;Reproduce&nbsp;the&nbsp;analysis](#-reproduce-the-analysis)

## Living with fire   

As the climate heats up, severe fire weather is getting worse in many parts of the world.

The effort of fighting fiercer fires for longer is putting strain on firefighting forces, and their resources with which to prepare are shrinking. They can no longer rely on backup from less affected countries, as northern and southern hemisphere fire seasons are beginning to overlap, and with fewer days in which to do prescribed burning, it’s getting harder to manage the fuel available for potential fires.

For Australia, the return of El Niño and a positive Indian Ocean Dipole primes the country for hotter, drier conditions—and with them, higher fire danger. Many communities flagged for higher risk are still recovering from devastating floods last year.

As the country prepares for a hot, dry summer, 360info looks at what’s changing and the lessons fire authorities are applying to fight the next set of fires.  

## Bushfire Prone Land  

This Australia-wide dataset combines all state and territory agency datasets describing land areas classified as 'Bushfire Prone'. Definitions and methodologies vary widely from state-to-state. This map attempts to unify the basic definitions to contrast policy and highlight considerations for planning, the built environment and living with fire.  

![](img/img.png)

## ♻️ Use + Remix rights

![[Creative Commons Attribution 4.0](https://creativecommons.org/licenses/by/4.0)](https://mirrors.creativecommons.org/presskit/buttons/80x15/png/by.png)

These charts, as well as the analyses that underpin them, are available under a Creative Commons Attribution 4.0 licence. This includes commercial reuse and derivates.

<!-- Do any of the data sources fall under a different licence? If so, describe the licence and which parts of the data fall under it here! if most of it does, change the above and replace LICENCE.md too -->

Data in these charts comes from:

* [report_datasources_links]

**Please attribute 360info and the data sources when you use and remix these visualisations.**

## 💻 Reproduce the analysis

### Quickstart: use the dev container

This project comes with a ready-to-use [dev container](https://code.visualstudio.com/docs/remote/containers) that includes everything you need to reproduce the analysis (or do a similar one of your own!), including [R](https://r-project.org) and [Quarto](https://quarto.org).

1. [Launch this project in GitHub Codespaces](https://github.com/codespaces/new?hide_repo_select=true&ref=main&repo=[report_codespaces_id])
2. If you have Docker installed, you can build and run the container locally:
  - Download or clone the project
  - Open it in [Visual Studio Code](https://code.visualstudio.com)
  - Run the **Remote-Containers: Reopen in Container** command

Once the container has launched (it might take a few minutes to set up the first time), you can run the analysis scripts with:

```sh
quarto render
```

Or look for the `.qmd` files to modify the analysis.

### Manual setup

To setup a development environment manually, 

You'll need to:
- [Download and install Quarto](https://quarto.org/docs/get-started)
- [Download the install R](https://www.r-project.org)
- Satisfy the R package dependencies. In R:
  * Install the [`renv`](https://rstudio.github.io/renv) package with `install.packages("renv")`,
  * Then run `renv::restore()` to install the R package dependencies.
  * (For problems satisfying R package dependencies, refer to [Quarto's documentation on virtual environments](https://quarto.org/docs/projects/virtual-environments.html).)

Now, render the `.qmd` files to the `/out` directory with:

```sh
quarto render
```

## ❓ Help

If you find any problems with our analysis or charts, please feel free to [create an issue](https://github.com/360-info/[report repo name]/issues/new)!
