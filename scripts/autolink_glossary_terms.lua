-- Link the first occurrence of each glossary term to Appendix F anchors.

local TERM_INDEX_PATH = "temp/d1-glossary-terms.json"

local terms = {}
local candidates_by_first = {}
local seen = {}

local function norm(s)
  s = (s or ""):lower()
  s = s:gsub("^%s+", "")
  s = s:gsub("%s+$", "")
  s = s:gsub("%s+", " ")
  return s
end

local function norm_word(s)
  s = norm(s)
  s = s:gsub("^[%p]+", "")
  s = s:gsub("[%p]+$", "")
  return s
end

local function split_tokens(term)
  local t = {}
  for token in term:gmatch("%S+") do
    local w = norm_word(token)
    if w ~= "" then
      t[#t + 1] = w
    end
  end
  return t
end

local function load_terms()
  local f = io.open(TERM_INDEX_PATH, "r")
  if not f then
    return
  end

  local raw = f:read("*a")
  f:close()

  local decoded = pandoc.json.decode(raw)
  if type(decoded) ~= "table" then
    return
  end

  for _, item in ipairs(decoded) do
    local term = norm(item.term or "")
    local anchor = item.anchor or ""
    if term ~= "" and anchor ~= "" then
      local tokens = split_tokens(term)
      if #tokens > 0 then
        local entry = {
          key = term,
          anchor = anchor,
          tokens = tokens,
          token_count = #tokens,
          char_count = #term,
        }
        terms[#terms + 1] = entry
        local first = tokens[1]
        if not candidates_by_first[first] then
          candidates_by_first[first] = {}
        end
        table.insert(candidates_by_first[first], entry)
      end
    end
  end

  for _, list in pairs(candidates_by_first) do
    table.sort(list, function(a, b)
      if a.token_count ~= b.token_count then
        return a.token_count > b.token_count
      end
      return a.char_count > b.char_count
    end)
  end
end

local function is_space_inline(inl)
  return inl.t == "Space" or inl.t == "SoftBreak" or inl.t == "LineBreak"
end

local function copy_range(inlines, i, j)
  local out = pandoc.List:new()
  for k = i, j do
    out:insert(inlines[k])
  end
  return out
end

local function match_term(inlines, start_idx, entry)
  local j = start_idx

  for token_idx, wanted in ipairs(entry.tokens) do
    while j <= #inlines and is_space_inline(inlines[j]) do
      j = j + 1
    end

    if j > #inlines or inlines[j].t ~= "Str" then
      return nil
    end

    local got = norm_word(inlines[j].text)
    if got ~= wanted then
      return nil
    end

    j = j + 1

    if token_idx < #entry.tokens then
      local had_space = false
      while j <= #inlines and is_space_inline(inlines[j]) do
        had_space = true
        j = j + 1
      end
      if not had_space then
        return nil
      end
    end
  end

  return j - 1
end

local function link_first_occurrences(inlines)
  local out = pandoc.List:new()
  local i = 1

  while i <= #inlines do
    local inl = inlines[i]

    if inl.t == "Link" or inl.t == "Code" or inl.t == "CodeBlock" then
      out:insert(inl)
      i = i + 1
    elseif inl.t == "Str" then
      local first = norm_word(inl.text)
      local linked = false
      local candidates = candidates_by_first[first]

      if candidates then
        for _, entry in ipairs(candidates) do
          if not seen[entry.key] then
            local end_idx = match_term(inlines, i, entry)
            if end_idx then
              local label = copy_range(inlines, i, end_idx)
              out:insert(pandoc.Link(label, "#" .. entry.anchor))
              seen[entry.key] = true
              i = end_idx + 1
              linked = true
              break
            end
          end
        end
      end

      if not linked then
        out:insert(inl)
        i = i + 1
      end
    else
      out:insert(inl)
      i = i + 1
    end
  end

  return out
end

local function should_skip_section(current_h1)
  if not current_h1 then
    return false
  end

  local t = norm(current_h1)
  if t:find("appendix f %- glossary", 1, false) then
    return true
  end
  if t:find("appendix g %- glossary", 1, false) then
    return true
  end
  return false
end

function Pandoc(doc)
  load_terms()

  if #terms == 0 then
    return doc
  end

  local current_h1 = nil

  for i, block in ipairs(doc.blocks) do
    if block.t == "Header" and block.level == 1 then
      current_h1 = pandoc.utils.stringify(block.content)
    elseif (block.t == "Para" or block.t == "Plain") and not should_skip_section(current_h1) then
      doc.blocks[i].content = link_first_occurrences(block.content)
    end
  end

  return doc
end
