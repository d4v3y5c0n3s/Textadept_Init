
function switch_to_nil_mode()
  keys.mode = nil
  ui.statusbar_text = '[INSERT MODE]'
end

keys.xah_mode = {
  ['esc'] = function()
    switch_to_nil_mode()
  end,
  ['f'] = function()
    switch_to_nil_mode()
  end,
  ['i'] = function()
    if buffer.selection_empty then
      buffer.line_up()
    else
      buffer.line_up_extend()
    end
  end,
  ['k'] = function()
    if buffer.selection_empty then
      buffer.line_down()
    else
      buffer.line_down_extend()
    end
  end,
  ['j'] = function()
    if buffer.selection_empty then
      buffer.char_left()
    else
      buffer.char_left_extend()
    end
  end,
  ['l'] = function()
    if buffer.selection_empty then
      buffer.char_right()
    else
      buffer.char_right_extend()
    end
  end,
  ['u'] = function()
    if buffer.selection_empty then
      buffer.word_left_end()
    else
      buffer.word_left_end_extend()
    end
  end,
  ['o'] = function()
    if buffer.selection_empty then
      buffer.word_right_end()
    else
      buffer.word_right_end_extend()
    end
  end,
  [','] = function() ui.goto_view(1) end,
  ['h'] = function()
    if buffer.selection_empty then
      buffer.para_up()
    else
      buffer.para_up_extend()
    end
  end,
  [';'] = function()
    if buffer.selection_empty then
      buffer.para_down()
    else
      buffer.para_down_extend()
    end
  end,
  ['p'] = function() buffer.add_text(' ') end,
  ['s'] = function() buffer.add_text('\n') end,
  ['d'] = buffer.delete_back,
  ['e'] = buffer.del_word_left,
  ['r'] = buffer.del_word_right,
  ['v'] = buffer.paste,
  ['y'] = buffer.undo,
  ['c'] = buffer.copy,
  ['x'] = buffer.cut,
  ['t'] = function()
    if buffer.selection_empty then
      buffer.char_right_extend()
    else
      buffer.set_empty_selection(buffer.current_pos)
    end
  end,
  ['5'] = buffer.clear,
  ['6'] = function()
    if buffer.selection_empty then
      textadept.editing.select_paragraph()
    else
      buffer.set_empty_selection(buffer.current_pos)
    end
  end,
  ['7'] = function()
    if buffer.selection_empty then
      textadept.editing.select_line()
    else
      buffer.set_empty_selection(buffer.current_pos)
    end
  end,
  ['8'] = function()
    if buffer.selection_empty then
      textadept.editing.select_word()
    else
      buffer.set_empty_selection(buffer.current_pos)
    end
  end,
  ['9'] = function()
    if buffer.selection_empty then
      textadept.editing.select_enclosed()
    else
      buffer.set_empty_selection(buffer.current_pos)
    end
  end,
  ['g'] = function()
    buffer.set_selection(0, 0)
    textadept.editing.select_paragraph()
    buffer.clear()
  end,
  ['b'] = buffer.upper_case,
  ['/'] = function() end,--goto matching bracket
  ['a'] = function() end,--command entry
  ['m'] = function() end,--goto left bracket
  ['.'] = function() end,--goto right bracket
  ['z'] = function()
    textadept.editing.toggle_comment()
  end,
  ['n'] = function()
    ui.find.focus()
  end,
  ['`'] = function() view.goto_buffer(_G.view, 1) end,
  ['3'] = function()
    view.unsplit(_G.view)
  end,
  ['4'] = function()
    view.split(_G.view, false)
  end,
  
  -- Unused keys
  ['1'] = function() end,
  ['2'] = function() end,
  ['0'] = function() end,
  ['-'] = function() end,
  ['='] = function() end,
  ['['] = function() end,
  [']'] = function() end,
  ['\\'] = function() end,
  ['\''] = function() end,
  [' '] = function() end,
  ['\n'] = function() end
}

keys['alt+j'] = function()
  keys.mode = 'xah_mode'
  ui.statusbar_text = '[XAH MODE]'
end
keys['esc'] = function()
  keys.mode = 'xah_mode'
  ui.statusbar_text = '[XAH MODE]'
end

events.connect(events.UPDATE_UI, function()
  if keys.mode == 'xah_mode' then
    ui.statusbar_text = '[XAH MODE]'
  elseif keys.mode == nil then
    ui.statusbar_text = '[INSERT MODE]'
  end
end)

events.connect(events.FIND_TEXT_CHANGED, function()
  textadept.editing.goto_line(1)
  ui.find.find_next()
end)

-- theme
view:set_theme(not CURSES and 'base16-gruvbox-dark-hard' or 'term')

-- wrap lines by default
view.wrap_mode = view.WRAP_WORD

-- find defaults
ui.find.regex = true

-- tab settings
buffer.use_tabs = false
buffer.tab_width = 2
