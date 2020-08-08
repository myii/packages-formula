# -*- coding: utf-8 -*-
# vim: ft=yaml
---
packages:
  chocolatey:
    wanted:
      adobereader: {}
      Firefox:
        package_args: "/l:en-GB"
      jq:
        version: '1.5'
        # `1.6` already installed on the pre-salted image
        force: true
      notepadplusplus:
        version: '7.8.8'
    unwanted:
      - GoogleChrome
      - hg
