#!/usr/bin/env bash

kill $(ps aux | grep server | awk '{print $2}')

