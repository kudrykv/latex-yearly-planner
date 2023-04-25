package entities

type Notes []Note

func (r Notes) IsEmpty() bool {
	return len(r) == 0
}

type Note struct {
	Name     string
	Contents []byte
}

func (r Note) IsEmpty() bool {
	return len(r.Name) == 0 && len(r.Contents) == 0
}
