#local ({
r <- getOption('repos')
r['CRAN'] <- 'https://cloud.r-project.org'
options(repos = r)
rm (r)
#        })

# http://stackoverflow.com/questions/24387660/how-to-change-libpaths-permanently-in-r
# Note that the order of these has to be reversed for initial installation of
# nvimcom, then they can be reset.
#.libPaths(c ('/usr/local/lib/R/site-library', .libPaths ()))
.libPaths(c ('/usr/lib/R/library', .libPaths ()))
.libPaths(c ('~/R/x86_64-pc-linux-gnu-library/4.4', .libPaths ()))

#options (stringsAsFactors=FALSE)
#options (max.print=100)
options (width = 80)
options (scipen = 10)
options (editor = 'vim')
options (browser = 'firefox')
#options (prompt='R> ', digits=4)

# https://github.com/REditorSupport/languageserver/issues/503
# cat("<project> [start]", Sys.getpid(), paste0(commandArgs(), collapse = " "), file = "~/rprofile.log", append = TRUE)
# options(languageserver.debug = function(options) {
#     TRUE
# })
options(languageserver.formatting_style = function(options) {
    spaceout::spaceout_style ()
})
options(languageserver.diagnostics = FALSE)
# cat("[end]", "\n", file = "~/rprofile.log", append = TRUE)

utils::rc.settings(ipck = TRUE) # tab-complete package names

.env <- new.env()
.env$setpar <- function (mar = c(3, 3, 2, 1), mgp = c(1.7, 0.3, 0)) {
    par (mar = mar, mgp = mgp)
}

.env$myfoghorn <- function (email = "mark.padgham@email.com") {
    x <- foghorn::summary_cran_results (email = email)
    for (type in c ("error", "fail", "warn", "note")) {
        p <- x$package [x [[type]] > 0]
        if (length (p) > 0) {
            for (i in p) {
                print (cli::rule (left = i))
                xi <- foghorn::cran_details (pkg = i)
                for (j in seq (nrow (xi))) {
                    print (cli::boxx (paste0 (xi$result [j],
                        " (N = ", xi$n_flavors [j], ")"),
                        padding = c (0, 5, 0, 5)))
                    message (xi$message [j])
                }
            }
        }
    }
}
attach(.env)

.First <- function(){
    if(interactive()){

        if ('colorout' %in% rownames (utils::installed.packages ()))
        {
            require (colorout, quietly = TRUE)
            # default normal green too faint for light bg
            #colorout::show256Colors() # to see colours
            #colorout::setOutputColors (normal = 0, string = 208, stderror = 21,
            #                           verbose = FALSE)
            # and this for dark bg:
            colorout::setOutputColors (normal = 244, string = 208, stderror = 21,
                verbose = FALSE)
        }

        rv <- R.Version ()$version.string
        rn <- R.Version ()$nickname
        rpl <- R.Version ()$platform
        rsys <- Sys.info ()
        ss <- system ('cat /etc/os-release', intern = T)
        ss_name <- gsub ("^NAME=\"|\"$", "", ss [1])

        lns <- list ()
        lns [[1]] <- paste0 (rv, '--- \'', rn, '\'')
        lns [[2]] <- paste0 (ss_name, ' (kernel ', rsys ['release'], ')')
        lns [[3]] <- paste0 ('machine = ', rpl, ': ', rsys ['nodename'])
        lns [[4]] <- paste0 ('wd: ', getwd ())
        lns <- sapply (lns, function (i) 
            {
                if ((nchar (i) %% 2) != 0)
                i <- paste0 (i, ' ')
                return (i)
            })
        nc <- max (sapply (lns, nchar))
        gap <- 2 # number of character before and after
        nci <- sapply (lns, nchar, USE.NAMES=FALSE)
        gaplen <- floor (nc + 2 * gap - nci) / 2

        # -------------------- START R SYMBOL -------------------
        #
        # This is centred around the system messages which needs to previous
        # code to determine `nc`. Starts with a function to get current colour
        # scheme (light or dark):
        scheme_is_dark <- function () {
            brc <- readLines ("~/.bashrc")
            cs <- grep ("NVIM_COLOUR_SCHEME", brc, value = TRUE)
            grepl ("none", cs [1])
        }
        BG <- ifelse (scheme_is_dark (), "\033[0;97m", "\033[0;90m" )
        NC <- '\033[0m'
        BLUE <- '\033[1;94m'

        msg1 <-  "             .,,,,,,,,,,,,,              " # copy of 1st line below
        nc_msg <- nchar (msg1) + 2 * gap
        indent <- (nc + gap + 2) - nc_msg
        indent <- paste0 (rep (" ", indent), collapse = "")

        message (BG, indent, "             .,,,,,,,,,,,,,              ", NC)
        message (BG, indent, "       ,,,,,,,,,,,,,,,,,********         ", NC)
        message (BG, indent, "    ,,,,,,,,,,,,,,,,,**************      ", NC)
        message (BG, indent, "  ,,,,,,,,,,,,                  *****    ", NC)
        message (BG, indent, " ,,,,,,,,,      ", BLUE, "RRRRRRRRRRRRRRRR", BG, "   ***   ", NC)
        message (BG, indent, ",,,,,,,,,       ", BLUE, "RRRRRRRRRRRRRRRRRRR", BG, " ***  ", NC)
        message (BG, indent, ",,,,,,,,        ", BLUE, "RRRRRRRRRRRRRRRRRRRR", BG, " //  ", NC)
        message (BG, indent, ",,,,,,*         ", BLUE, "RRRRRRR      RRRRRRR", BG, " //  ", NC)
        message (BG, indent, ",,,*****        ", BLUE, "RRRRRRR     RRRRRRR", BG, "  //  ", NC)
        message (BG, indent, " ********       ", BLUE, "RRRRRRRRRRRRRRRRRR", BG, "  //   ", NC)
        message (BG, indent, "   *********    ", BLUE, "RRRRRRRRRRRRRR", BG, "    //     ", NC)
        message (BG, indent, "      **********", BLUE, "RRRRRRR   RRRRRRR", BG, "        ", NC)
        message (BG, indent, "         *******", BLUE, "RRRRRRR    RRRRRRR", BG, "       ", NC)
        message (BG, indent, "                ", BLUE, "RRRRRRR     RRRRRRRR", BG, "     ", NC)
        # -------------------- END R SYMBOL -------------------

        message ("\n")

        #for (i in 2500:2600)
        #    cat(eval(parse(text=paste("\"\\u", i, "\"", sep=""))), " ")
        top <- "\u2583"
        bot <- "\u2580"
        vc <- "\u2588"

        bl <- '  ' # blanks at left side
        top_half <- paste0 (rep (top, gap + nc / 2 - 1))
        message (bl, top_half, ' R ', top_half, top)
        message (paste0 (bl, vc, paste0 (rep (' ', gap + nc + 1), collapse=''), ' ', vc))
        for (i in 1:length (lns))
        {
            gaps <- paste0 (rep (' ', gaplen [i]), collapse='')
            message (paste0 (bl, vc, gaps, lns [[i]], gaps, vc))
        }
        message (paste0 (bl, vc, paste0 (rep (' ', gap + nc + 1), collapse=''), ' ', vc))
        bot_half <- paste0 (rep (bot, gap + nc / 2 - 1))
        message (bl, bot_half, ' R ', bot_half, bot)
        message ('')

        if (curl::has_internet ()) {
            # only check for new packages once per day
            chk_file <- "~/.Rold_pkg_check"
            do_check <- TRUE
            today <- strsplit (as.character (Sys.time ()), " ") [[1]] [1]
            if (file.exists (chk_file))
            {
                #chk_date <- utils::read.table (chk_file, as.is=TRUE) [1, 1]
                chk_date <- readLines (chk_file) [1]
                if (chk_date == today)
                do_check = FALSE
            }
            write (today, file = chk_file)
            if (do_check)
            {
                cli::cli_h2 (paste0 ("Old package check for ", today))
                old <- utils::old.packages ()
                if (!is.null (old)) {
                    cli::cli_alert_info ("Updatable packages:")
                    cli::cli_ol(items = rownames (old))
                    message ("\n")
                } else 
                message ('All packages up to date\n')

                cli::cli_h2 ("foghorn results")
                x <- foghorn::summary_cran_results (email = "mark.padgham@email.com")
                if (sum (x [, c ("error", "fail", "warn", "note")]) > 0)
                cli::cli_text ("Run '.env$myfoghorn()' for details")
            }
        } else {
            message ('nope, no internet\n')
        }
    }
}

# vapoRwave::new_retro as default ggplot2 theme, with tweaks that should be
# fixed and able to be removed with my PR
# https://github.com/moldach/vapoRwave/pull/3
vw <- FALSE
if (vw) {
    suppressMessages (
        th <- ggplot2::theme_minimal ()
    )
    nr <- vapoRwave::new_retro ()

    th$axis.title.x <- th$axis.title.y <- nr$axis.title
    th$panel.grid <- nr$panel.grid.major.x
    nr$axis.title <- nr$panel.grid.major.x <- nr$panel.grid.major.y <- NULL

    nr <- nr [which (names (nr) %in% names (th))]
    th [match (names (nr), names (th))] <- nr

    ggplot2::theme_set (th)
    rm (nr, th)
}
rm (vw)
