package noting

type PatternDotted struct{}

func (r PatternDotted) Render(width Width, height Height) string {
	return "dotted"
}
