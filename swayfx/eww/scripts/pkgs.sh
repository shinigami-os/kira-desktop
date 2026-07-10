#!/bin/sh
flux list 2>/dev/null | wc -l || echo 0
