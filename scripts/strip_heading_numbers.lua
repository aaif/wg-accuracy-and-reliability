-- Remove explicit numeric prefixes in headings when --number-sections is enabled.
-- Example: "1.5 Internal consistency" -> "Internal consistency"

function Header(el)
  local txt = pandoc.utils.stringify(el.content)

  -- Remove leading numeric marker forms such as:
  -- "§1", "§1.2", "1", "1.2", including accidental duplicates.
  local stripped = txt

  for _ = 1, 3 do
    stripped = stripped
      :gsub("^%s*§%s*%d+[%.%d]*%s*[-–—:.]*%s*", "")
      :gsub("^%s*%d+[%.%d]*%s*[-–—:.]*%s*", "")
  end

  if stripped ~= txt and stripped ~= "" then
    return pandoc.Header(el.level, stripped, el.attr)
  end

  return el
end
