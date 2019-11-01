* Add mappings to jump to next/previous line based on indentation
    * If the next line is at the same indentation, scan until next line of lower
      indentation
    * If the next line is at a higher indentation, scan until next line of same
      indentation or lower indentation from current line
    * If the next line is at a lower indentation, go to the next line
