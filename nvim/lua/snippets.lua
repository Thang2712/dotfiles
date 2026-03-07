local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node

-- ======================
-- JavaScript / TypeScript
-- ======================

local js_snippets = {

	-- console.log
	s("cl", {
		t("console.log("),
		i(1),
		t(");"),
		i(0),
	}),

	-- try / catch
	s("tryc", {
		t({ "try {", "\t" }),
		i(1),
		t({ "", "} catch (err) {", "\tconsole.error(err);", "}" }),
		i(0),
	}),

	-- arrow function
	s("afn", {
		t("("),
		i(1, "args"),
		t(") => {"),
		t({ "", "\t" }),
		i(2),
		t({ "", "}" }),
		i(0),
	}),
}

ls.add_snippets("javascript", js_snippets)
ls.add_snippets("typescript", js_snippets)

-- ======
-- Python
-- ======

ls.add_snippets("python", {

	s("pr", {
		t("print("),
		i(1),
		t(")"),
		i(0),
	}),

	s("main", {
		t({ 'if __name__ == "__main__":', "\t" }),
		i(0),
	}),

	s("trye", {
		t({ "try:", "\t" }),
		i(1),
		t({ "", "except Exception as e:", "\tprint(e)" }),
		i(0),
	}),
})

-- ===
-- C
-- ===

ls.add_snippets("c", {

	s("main", {
		t({ "int main(int argc, char **argv) {", "\t" }),
		i(1),
		t({ "", "\treturn 0;", "}" }),
		i(0),
	}),

	s("pf", {
		t('printf("'),
		i(1),
		t('\\n");'),
		i(0),
	}),

	s("if", {
		t("if ("),
		i(1),
		t({ ") {", "\t" }),
		i(2),
		t({ "", "}" }),
		i(0),
	}),
})

-- ============
-- Snippet jump
-- ============

vim.keymap.set({ "i", "s" }, "<C-l>", function()
	if ls.jumpable(1) then
		ls.jump(1)
	end
end, { silent = true })

vim.keymap.set({ "i", "s" }, "<C-h>", function()
	if ls.jumpable(-1) then
		ls.jump(-1)
	end
end, { silent = true })
