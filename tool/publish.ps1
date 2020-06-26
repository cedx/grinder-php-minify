#!/usr/bin/env pwsh
Set-StrictMode -Version Latest
Set-Location (Split-Path $PSScriptRoot)

tool/clean.ps1
dartfmt --fix --overwrite lib test
pub publish --force