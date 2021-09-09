package hyper

func Target(ref, text string) string {
	return "\\hypertarget{" + ref + "}{" + text + "}"
}

func Link(ref, text string) string {
	return "\\hyperlink{" + ref + "}{" + text + "}"
}
