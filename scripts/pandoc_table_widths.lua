-- Assign non-zero relative widths to table columns for LaTeX output.
-- This nudges Pandoc's LaTeX writer to use wrapping-friendly column specs.

function Table(tbl)
  if FORMAT ~= "latex" then
    return nil
  end

  local n = #tbl.colspecs
  if n == 0 then
    return nil
  end

  local default_width = 1.0 / n
  local updated = {}

  for i, spec in ipairs(tbl.colspecs) do
    local align = spec[1]
    local width = spec[2]

    if width == nil or width == 0 then
      width = default_width
    end

    updated[i] = { align, width }
  end

  tbl.colspecs = updated
  return tbl
end
