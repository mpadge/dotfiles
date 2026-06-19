rm .github/workflows/test-coverage.yaml .github/workflows/R-CMD-check.yaml
Rscript -e "usethis::use_github_action('test-coverage')"
Rscript -e "usethis::use_github_action('check-standard')"
if [ -f .github/workflows/pkgdown.yaml ]; then
    Rscript -e "usethis::use_github_action('pkgdown')"
fi
