#!/usr/bin/bash

.cabal-sandbox/bin/site build && cp -r _site/* /var/www/gambogi
