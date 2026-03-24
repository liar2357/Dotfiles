#!/usr/bin/env bash

waydroid status | grep -q "RUNNING" || waydroid session start
waydroid show-full-ui
