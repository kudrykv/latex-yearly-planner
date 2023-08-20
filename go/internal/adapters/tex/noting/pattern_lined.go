package noting

type PatternLined struct{}

func (r PatternLined) Render(width Width, height Height) string {
	return "lined"
}
