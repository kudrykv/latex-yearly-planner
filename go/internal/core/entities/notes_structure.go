package entities

type NoteStructure struct {
	Index Note
	Notes Notes
}

func (r NoteStructure) IsEmpty() bool {
	return r.Index.IsEmpty() && r.Notes.IsEmpty()
}
