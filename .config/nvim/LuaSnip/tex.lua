-- TODO Make more readable
--  divide into multiple sections (files), ie math_mode

-- ----------------------------------------------------------------------------
-- Summary: When `LS_SELECT_RAW` is populated with a visual selection, the function
-- returns an insert node whose initial text is set to the visual selection.
-- When `LS_SELECT_RAW` is empty, the function simply returns an empty insert node.
local get_visual = function(args, parent)
  if (#parent.snippet.env.LS_SELECT_RAW > 0) then
    return sn(nil, i(1, parent.snippet.env.LS_SELECT_RAW))
  else -- If LS_SELECT_RAW is empty, return a blank insert node
    return sn(nil, i(1))
  end
end
-- ----------------------------------------------------------------------------
-- Some LaTeX-specific conditional expansion functions (requires VimTeX)

local tex_utils = {}
tex_utils.in_mathzone = function() -- math context detection
  return vim.fn['vimtex#syntax#in_mathzone']() == 1
end
tex_utils.in_text = function()
  return not tex_utils.in_mathzone()
end
tex_utils.in_comment = function() -- comment detection
  return vim.fn['vimtex#syntax#in_comment']() == 1
end
tex_utils.in_env = function(name) -- generic environment detection
  local is_inside = vim.fn['vimtex#env#is_inside'](name)
  return (is_inside[1] > 0 and is_inside[2] > 0)
end
-- A few concrete environments---adapt as needed
tex_utils.in_equation = function() -- equation environment detection
  return tex_utils.in_env('equation')
end
tex_utils.in_itemize = function() -- itemize environment detection
  return tex_utils.in_env('itemize')
end
tex_utils.in_tikz = function() -- TikZ picture environment detection
  return tex_utils.in_env('tikzpicture')
end
tex_utils.in_enumerate = function() -- enumerate environment detection
  return tex_utils.in_env('enumerate')
end

return {


  --------------------------------------------------------------
  ------------- Figure -------------------------
  s({ trig = "fig", name = "fig~", dscr = "Figure Enviroment" },
    fmta(
      [[
    \begin{figure} [H]
      \center
      \includegraphics[width=<>\textwidth]{figures/<>}
      \caption{<>}
    \end{figure}
  ]],
      {
        i(1, "percentof"),
        i(2, "filename"),
        i(3, "caption")
      })
  ),

  -- Examples of Greek letter snippets, autotriggered for efficiency
  s({ trig = ";a", regTrig = true, wordTrig = false, snippetType = "autosnippet" },
    {
      t("\\alpha"),
    },
    { condition = tex_utils.in_mathzone }
  ),
  s({ trig = ";b", regTrig = true, wordTrig = false, snippetType = "autosnippet" },
    {
      t("\\beta"),
    },
    { condition = tex_utils.in_mathzone }
  ),
  s({ trig = ";g", regTrig = true, wordTrig = false, snippetType = "autosnippet" },
    {
      t("\\gamma"),
    },
    { condition = tex_utils.in_mathzone }
  ),
  s({ trig = ";o", regTrig = true, wordTrig = false, snippetType = "autosnippet" },
    {
      t("\\omega"),
    },
    { condition = tex_utils.in_mathzone }
  ),
  s({ trig = ";z", regTrig = true, wordTrig = false, snippetType = "autosnippet" },
    {
      t("\\zeta"),
    },
    { condition = tex_utils.in_mathzone }
  ),

  s({ trig = ";t", regTrig = true, wordTrig = false, snippetType = "autosnippet" },
    {
      t("\\tau"),
    },
    { condition = tex_utils.in_mathzone }
  ),

  s({ trig = ";p", regTrig = true, wordTrig = false, snippetType = "autosnippet" },
    {
      t("\\psi"),
    },
    { condition = tex_utils.in_mathzone }
  ),

  -- sciunitx package
  s({ trig = ";ev", snippetType = "autosnippet" },
    {
      t("\\electronvolt"),
    }
  ),

  -- for siunitx package
  s({ trig = "[^\\]qty", regTrig = true, wordTrig = false, name = "qty", snippetType = "autosnippet" },
    fmta(
      "<>\\qty{<>}{<>}",
      {
        f(function(_, snip) return snip.captures[1] end),
        i(1, "number"),
        i(2, "unit")
      }
    )
  ),

  -- \frac
  s({
      trig = "([^%a])ff",
      regTrig = true,
      wordTrig = false,
      name = "frac",
      dscr = "Fraction Env",
      snippetType =
      "autosnippet"
    },
    fmta(
      "<>\\frac{<>}{<>}",
      {
        f(function(_, snip) return snip.captures[1] end),
        i(1),
        i(2)
      }
    ),
    { condition = tex_utils.in_mathzone }
  ),

  -- \int(egral)
  s({ trig = "int", wordTrig = true, name = "int", dscr = "Integral Env" },
    fmta(
      "\\int_{<>}^{<>}",
      {
        i(1),
        i(2)
      }
    ),
    { condition = tex_utils.in_mathzone }
  ),

  -- Equation
  s({ trig = "beq", dscr = "Equation environment w/o numbering", snippetType = "autosnippet" },
    fmta(
      [[
     \begin{equation*}
       <>
     \end{equation*}
   ]],
      { i(1) }
    )
  ),

  -- begin and end environment
  s({ trig = "beg", dscr = "Create a new environment", },
    fmta(
      [[
      \begin{<>}<>
        <>
      \end{<>}
    ]],
      {
        i(1, "env"),
        i(2),
        i(3),
        rep(1), -- this node repeats insert node i(1)
      }
    )
  ),

  s({ trig = "([%s])bk", regTrig = true, wordTrig = false, snippetType = "autosnippet" },
    fmta("<>\\braket{<>}",
      {
        f(function(_, snip) return snip.captures[1] end),
        i(1)
      }
    ),
    { condition = tex_utils.in_mathzone }
  ),
  
  -- vector \vec{<>}
  s({ trig = "([%s])ve", regTrig = true, wordTrig = false, snippetType = "autosnippet" },
    fmta("<>\\vec{<>}",
      {
        f(function(_, snip) return snip.captures[1] end),
        i(1)
      }
    ),
    { condition = tex_utils.in_mathzone }
  ),

  -- Inline Math Mode
  s({ trig = "([^%a])mm", regTrig = true, wordTrig = false, snippetType = "autosnippet" },
    fmta("<>$ <> $",
      {
        f(function(_, snip) return snip.captures[1] end),
        d(1, get_visual),
      }
    ),
    { condition = not tex_utils.in_mathzone }
  ),

  -- Expanded Math Mode
  s({ trig = "([^%a])MM", regTrig = true, wordTrig = false, snippetType = "autosnippet" },
    fmta(
      [[
<>
\[
  <>
<>\]
      ]],
      {
        f(function(_, snip) return snip.captures[1] end),
        d(1, get_visual),
        i(2),
      }
    ),
    { condition = not tex_utils.in_mathzone }
  ),
  -- Expanded Math Mode at start of line
  s({ trig = "^MM", regTrig = true, wordTrig = false, snippetType = "autosnippet" },
    fmta(
      [[
<>\[
  <>
<>\]
      ]],
      {
        f(function(_, snip) return snip.captures[1] end),
        d(1, get_visual),
        i(2),
      }
    ),
    { condition = not tex_utils.in_mathzone }
  ),

  -- Example: italic font implementing visual selection
  s({ trig = "tii", dscr = "Expands 'tii' into LaTeX's textit{} command." },
    fmta("\\textit{<>}",
      {
        d(1, get_visual),
      }
    )
  ),

  -- Example: bold font implementing visual selection
  s({ trig = "tbf", dscr = "Expands 'tbf' into LaTeX's textbf{} command." },
    fmta("\\textbf{<>}",
      {
        d(1, get_visual),
      }
    )
  ),

  -- Example: typewriter font implementing visual selection
  s({ trig = "ttt", dscr = "Expands 'ttt' into LaTeX's texttt{} command." },
    fmta("\\texttt{<>}",
      {
        d(1, get_visual),
      }
    )
  ),

  -- exponential auto
  s({ trig = "([^%a])ee", regTrig = true, wordTrig = false, snippetType = "autosnippet" },
    fmta("<>e ^ {<>}",
      {
        f(function(_, snip) return snip.captures[1] end),
        i(1)
      }
    ),
    { condition = tex_utils.in_mathzone }
  ),

  -- zero subscript snippet
  s({ trig = '([%a%)%]%}])00', regTrig = true, wordTrig = false, snippetType = "autosnippet" },
    fmta(
      "<>_{<>}",
      {
        f(function(_, snip) return snip.captures[1] end),
        t("0")
      }
    ),
    { condition = tex_utils.in_mathzone }
  ),


  -- sub scripts
  s({ trig = '(%a)(%d)', regTrig = true, name = 'auto subscript', snippetType = "autosnippet" },
    fmta([[<>_<>]],
      {
        f(function(_, snip) return snip.captures[1] end),
        f(function(_, snip) return snip.captures[2] end)
      }
    ),
    { condition = tex_utils.in_mathzone }
  ),

  -- dot and ddot functions
  --s({ trig = 'ddo', name = 'Second Derivative', snippetType = "autosnippet" },
  --  fmta([[\ddot{<>}]],
  --    i(1)
  --  ),
  --  { condition = tex_utils.in_mathzone }
  --),
  --s({ trig = 'do', name = 'First Derivative', snippetType = "autosnippet" },
  --  fmta([[\dot{<>}]],
  --    i(1)
  --  ),
  --  { condition = tex_utils.in_mathzone }
  --),

  -- -------------------------------------------------------------------------------
  -- item list stuff
  s({ trig = '--', snippetType = "autosnippet" },
    t("\\item "),
    { condition = tex_utils.in_enumerate or tex_utils.in_itemize }
  ),
  s({ trig = '-=', snippetType = "autosnippet" },
    fmta("\\item [<>]",
      i(1)
    ),
    { condition = tex_utils.in_enumerate or tex_utils.in_itemize }
  ),
  -- --------------------------------------------------------------------------------
  -- left right delimeters
  -- parentheses
  s({ trig = 'lrp', snippetType = "autosnippet" },
    fmta("\\left( <> \\right)",
      i(1)
    ),
    { condition = tex_utils.in_mathzone }
  ),
  -- brackets
  s({ trig = 'lr[', snippetType = "autosnippet" },
    fmta("\\left[ <> \\right]",
      i(1)
    ),
    { condition = tex_utils.in_mathzone }
  ),
  -- bars
  s({ trig = 'lr|', snippetType = "autosnippet" },
    fmta("\\left| <> \\right|",
      i(1)
    ),
    { condition = tex_utils.in_mathzone }
  ),
  -- curly
  s({ trig = 'lr{', snippetType = "autosnippet" },
    fmta("\\left\\{ <> \\right\\}",
      i(1)
    ),
    { condition = tex_utils.in_mathzone }
  ),
}
