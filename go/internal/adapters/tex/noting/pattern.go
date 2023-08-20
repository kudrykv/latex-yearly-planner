package noting

func NewPattern(name string) Pattern {
	switch name {
	case "dotted":
		return PatternDotted{}
	case "lined":
		return PatternLined{}
	}

	return PatternError{}
}
