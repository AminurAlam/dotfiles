local ls = require('luasnip')
local s = ls.snippet
local sn = ls.snippet_node
local isn = ls.indent_snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local c = ls.choice_node
local d = ls.dynamic_node
local r = ls.restore_node
local events = require('luasnip.util.events')
local ai = require('luasnip.nodes.absolute_indexer')
local fmt = require('luasnip.extras.fmt').fmt
local extras = require('luasnip.extras')
local m = extras.m
local l = extras.l
local rep = extras.rep
local postfix = require('luasnip.extras.postfix').postfix

-- https://github.com/L3MON4D3/LuaSnip/blob/master/DOC.md

ls.add_snippets('python', {
    s('ternary', {
        i(1, 'cond'),
        t(' ? '),
        i(2, 'then'),
        t(' : '),
        i(3, 'else'),
    }),
})

ls.add_snippets('tex', {
    s('boil', {
        t('\\documentclass[12pt, letterpaper, twoside]{article}'),
        t('\\usepackage[utf8]{inputenc}'),
        t('\\usepackage{amsmath}'),
        t('\\usepackage{graphicx}'),
        t(''),
        t('\\title{ {\\LaTeX} document}'),
        t('\\author{AminurAlam}'),
        t('\\date{August 2012}'),
    }),
})
