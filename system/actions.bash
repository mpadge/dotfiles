#!/usr/bin/bash

REPODIR=/<path>/<to>/repos/
BASEURL='https://github.com/'

NC='\033[0m'
ARG='\033[0;31m' # red
TXT='\033[0;32m' # green, or 1;32m for light green
SYM='\u2192' # right arrow

# local directories to exclude
EXCLUDE=(
    "${REPODIR}mpadge/gender-ai/"
    "${REPODIR}pre-processing-r/rpp/"
    "${REPODIR}ropensci/dev_guide/"
    "${REPODIR}ropensci-org/pkgreviewr/"
    "${REPODIR}ropensci-review-tools/tree-sitter-diff/tests/csitter/tree-sitter/"
    "${REPODIR}ropensci/roweb3/"
    "${REPODIR}ropensci-stats/badges/"
    "${REPODIR}rosadmin/annual-reporting/"
)

grepCronJobs() {
    rg "\\-\\scron\\:" --hidden ${REPODIR} | cut -d: -f1 | awk '/\.github\// {
        split($0, parts, ".github/")
        print parts[1]
    }' | sort -u | grep -v -f <(printf "%s\n" "${EXCLUDE[@]}")
}

if [ "$1" == "" ] || [ "$1" == "help" ]; then
    echo -e "${TXT}Script to list or open pages of all repositories${NC}"
    echo -e "${TXT}containing cron jobs run on GitHub actions.${NC}"
    echo -e ""
    echo -e "${SYM} ${ARG}grep/list${NC}      : ${TXT}Grep all repos with cron workflows${NC}"
    echo -e "${SYM} ${ARG}open${NC}           : ${TXT}Open GitHub pages of all cron workflows${NC}"
    echo -e "${SYM} ${ARG}help (default)${NC} : ${TXT}Display these help messages${NC}"
elif [ "$1" == "grep" ] || [ "$1" == "list" ]; then
    echo -e "${TXT}The following directories have GitHub actions cron jobs:${NC}"
    echo -e ""
    grepCronJobs | while read -r line; do
        url="${line/$REPODIR/$BASEURL}"
        echo -e "${TXT}${line}${NC} ${SYM} ${ARG}${url}"
    done
elif [ "$1" == "open" ]; then
    grepCronJobs | sed 's|$|actions|' | while read -r line; do
        url="${line/$REPODIR/$BASEURL}"
        echo -e "${TXT}${line}${NC}"
        xdg-open "$url"
    done
else
    echo "Unknown option"
fi
