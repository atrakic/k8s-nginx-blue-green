#!/bin/bash
set -e
k6 --no-color run tests/k6.js
