package config

type Blocks struct {
	Title        Title
	Annual       Annual
	Quarterly    Quarterly
	Monthly      Monthly
	Weekly       Weekly
	Daily        Daily
	DailyWMonth  DailyWMonth
	DailyReflect DailyReflect
	DailyNotes   DailyNotes
	NotesIndexed NotesIndexed
	TodosIndexed TodosIndexed
}

type Title struct {
	Tpl string
}

type Annual struct {
	Tpl string
}

type Quarterly struct {
	Tpl string
}

type Monthly struct {
	Tpl string
}

type Weekly struct {
	Tpl string
}

type Daily struct {
	Tpl string
}

type DailyWMonth struct {
	Tpl string
}

type DailyReflect struct {
	Tpl string
}

type DailyNotes struct {
	Tpl string
}

type NotesIndexed struct {
	TplIndex string
	TplPage  string
}

type TodosIndexed struct {
	TplIndex string
	TplPage  string
}
