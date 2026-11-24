-- Rewrite relative links between Markdown sources for the published site.
-- LINK_MODE=page (default): foo.md -> foo.html, README.md -> index.html, dir/ -> dir/index.html
-- LINK_MODE=flat: links to local files become plain text (single page and PDF).
local mode = os.getenv("LINK_MODE") or "page"

function Link(l)
  local t = l.target
  if t:match("^%a[%w+.-]*:") or t:match("^#") or t:match("^//") then
    return nil
  end
  local path, frag = t:match("^([^#]*)(#?.*)$")
  local is_md = path:match("%.md$") ~= nil
  local is_dir = path:match("/$") ~= nil
  if not (is_md or is_dir) then
    return nil
  end
  if mode == "flat" then
    return l.content
  end
  if is_md then
    path = path:gsub("%.md$", ".html")
    path = path:gsub("README%.html$", "index.html")
  else
    path = path .. "index.html"
  end
  l.target = path .. frag
  return l
end
