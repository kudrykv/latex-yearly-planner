package notes

type PatternError struct{}

func (r PatternError) Render(_ Width, _ Height) string {
	return "unknown pattern"
}
